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
  #   reader = ONIX::Reader.new("somefile.xml", ONIX::APAProduct)
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
  #   reader = ONIX::Reader.new("somefile.xml", ONIX::APAProduct)
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
  class Reader
    include Enumerable

    attr_reader :header , :version, :xml_lang, :xml_version, :encoding

    def initialize(input, product_klass = ::ONIX::Product)
      if input.kind_of?(String)
        @file   = File.open(input, "r")
        @reader = Nokogiri::XML::Reader.from_io(@file)
      elsif input.kind_of?(IO)
        @reader = Nokogiri::XML::Reader.from_io(input)
      else
        raise ArgumentError, "Unable to read from file or IO stream"
      end

      @product_klass = product_klass

      @header = find_header

      @xml_lang    ||= @reader.lang
      @xml_version ||= @reader.xml_version.to_f
      @encoding    ||= encoding_const_to_name(@reader.encoding)
    end

    # Iterate over all the products in an ONIX file
    #
    def each(&block)
      @reader.each do |node|
        if @reader.node_type == 1 && @reader.name == "Product"
          str = normalise_string_encoding(@reader.outer_xml.to_s.dup)
          if str.size == 0
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

    def find_header
      100.times do
        @reader.read
        if @reader.node_type == 1 &&  @reader.name == "Header"
          str = normalise_string_encoding(@reader.outer_xml.to_s.dup)
          if str.size == 0
            return ONIX::Header.new
          else
            return ONIX::Header.from_xml(str)
          end
        end
      end
      return nil
    end

    # XML::Reader seems to transparently convert all input data to utf-8, howver
    # on Ruby 1.9 it fails to correctly set the encoding on the strings.
    #
    def normalise_string_encoding(str)
      if RUBY_VERSION >= "1.9"
        return str.dup.force_encoding("utf-8")
      else
        str
      end
    end

    # simple mapping of encoding constants to a string
    #
    def encoding_const_to_name(const)
      return nil if const.nil?
      case const
      when LibXML::XML::Encoding::UTF_8
        "utf-8"
      when LibXML::XML::Encoding::UTF_16LE
        "utf-16le"
      when LibXML::XML::Encoding::UTF_16BE
        "utf-16be"
      when LibXML::XML::Encoding::UCS_4LE
        "ucs-4le"
      when LibXML::XML::Encoding::UCS_4BE
        "ucs-4be"
      when LibXML::XML::Encoding::UCS_2
        "ucs-2"
      when LibXML::XML::Encoding::ISO_8859_1
        "iso-8859-1"
      when LibXML::XML::Encoding::ISO_8859_2
        "iso-8859-2"
      when LibXML::XML::Encoding::ISO_8859_3
        "iso-8859-3"
      when LibXML::XML::Encoding::ISO_8859_4
        "iso-8859-4"
      when LibXML::XML::Encoding::ISO_8859_5
        "iso-8859-5"
      when LibXML::XML::Encoding::ISO_8859_6
        "iso-8859-6"
      when LibXML::XML::Encoding::ISO_8859_7
        "iso-8859-7"
      when LibXML::XML::Encoding::ISO_8859_8
        "iso-8859-8"
      when LibXML::XML::Encoding::ISO_8859_9
        "iso-8859-9"
      when LibXML::XML::Encoding::ISO_2022_JP
        "iso-2022-jp"
      when LibXML::XML::Encoding::SHIFT_JIS
        "shift-jis"
      when LibXML::XML::Encoding::EUC_JP
        "euc-jp"
      when LibXML::XML::Encoding::ASCII
        "ascii"
      else
        nil
      end
    end
  end
end
