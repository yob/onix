# coding: utf-8

require 'stringio'

module ONIX

  # This is the primary class for reading data from an ONIX file, and there's
  # really not much to it
  #
  # Each file should contain a single header, and 1 or more products:
  #
  #   reader = ONIX::Reader.new("somefile.xml")
  #
  #   puts reader.header.inspect
  #
  #   reader.each do |product|
  #     puts product.inspect
  #   end
  #
  # The header will be returned as an ONIX::Header object, and the product will
  # be an ONIX::Product.
  #
  # The ONIX::Product class can be a bit of a hassle to work with, as data can be
  # nested in it fairly deeply. To wrap all the products returned by the reader
  # in a shim that provides simple accessor access to common attributes, pass the
  # shim class as a second argument
  #
  #   reader = ONIX::Reader.new("somefile.xml", :product_class => ONIX::APAProduct)
  #
  #   puts reader.header.inspect
  #
  #   reader.each do |product|
  #     puts product.inspect
  #   end
  #
  # APAProduct stands for Australian Publishers Association and provides simple
  # access to the ONIX attributes that are commonly used in the Australian market.
  #
  # As well as accessing the file header, there are handful of other read only
  # attributes that might be useful
  #
  #   reader = ONIX::Reader.new("somefile.xml")
  #
  #   puts reader.version
  #   puts reader.xml_lang
  #   puts reader.xml_version
  #   puts reader.encoding
  #
  # The version attribute is particuarly useful. There are multiple revisions of the
  # ONIX spec, and you may need to handle the file differently based on what
  # version it is.
  #
  # == File Encoding
  #
  # ONIX::Reader returns all strings as UTF-8. Source file encoding is detected by
  # the encoding declaration at the top of the file, like so:
  #
  #   <?xml version="1.0" encoding="iso-8859-1"?>
  #
  # If the encoding declaration is missing the file is assumed to be UTF-8.
  #
  # If the encoding declaration is missing or wrong and the file isn't UTF-8,
  # you can manually set or override it like so:
  #
  #   reader = ONIX::Reader.new("somefile.xml", :encoding => "iso-8859-1")
  #
  # If the file contains invalid bytes for the source encoding an exception will
  # be raised. This isn't ideal, but I'm still looking for ways to make this
  # behaviour configurable.
  #
  # If you're running 1.9, you might imagine passing an IO stream that auto
  # transcodes to UTF-8 into ONIX::Reader might have the same effect, but that
  # isn't the case. Nokogiri is used to parse the file, and it seems to ignore
  # IO encoding and just read raw bytes.
  #
  class Reader
    include Enumerable

    attr_reader :header, :release

    def initialize(input, *args)
      opts = args.last.kind_of?(Hash) ? args.pop : {}
      if args.size > 0
        ActiveSupport::Deprecation.warn("Passing a klass as ONIX::Reader's second argument is deprecated, use the :product_class option instead", caller)
      end
      @product_klass = opts[:product_class] || args.pop || ::ONIX::Product

      if input.kind_of?(String)
        @file   = File.open(input, "r")
        @reader = Nokogiri::XML::Reader(@file, nil, opts[:encoding]) { |cfg| cfg.dtdload.noent }
      elsif input.kind_of?(IO)
        @reader = Nokogiri::XML::Reader(input, nil, opts[:encoding]) { |cfg| cfg.dtdload.noent }
      else
        raise ArgumentError, "Unable to read from file or IO stream"
      end

      @release = find_release
      @header = find_header

      @xml_lang    ||= @reader.lang
      @xml_version ||= @reader.xml_version.to_f
    end

    # Iterate over all the products in an ONIX file
    #
    def each(&block)
      @reader.each do |node|
        if @reader.node_type == 1 && @reader.name == "Product"
          str = @reader.outer_xml
          if str.nil?
            yield @product_klass.new
          else
            yield @product_klass.from_xml(str)
          end
        end
      end
    end

    def close
      @reader.close if @reader
    end

    private

    def find_release
      2.times do
        @reader.read
        if @reader.node_type == 1 && @reader.name == "ONIXMessage"
          value = @reader.attributes["release"]
          if value
            return BigDecimal.new(value)
          else
            return nil
          end
        elsif @reader.node_type == 14
          return nil
        end
      end
      return nil
    end

    def find_header
      100.times do
        @reader.read
        if @reader.node_type == 1 &&  @reader.name == "Header"
          str = @reader.outer_xml
          if str.nil?
            return ONIX::Header.new
          else
            return ONIX::Header.from_xml(str)
          end
        end
      end
      return nil
    end
  end
end
