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

    attr_reader :header, :version, :xml_lang, :xml_version, :encoding, :queue

    # Create a new ONIX::Reader object
    #
    def initialize(input, product_klass = ::ONIX::Product)
      if input.kind_of? String
        @input = File.open(input)
      elsif input.kind_of?(IO)
        @input = input
      else
        throw "Unable to read from path or file"
      end

      raise ArgumentError, "Input is not an ONIX file" unless @input.read(1024).include?("ONIXMessage")

      @product_klass = product_klass
      @header = nil
      @offsets = read_offsets
      read_xml_attributes

      str = read_frag(@offsets.first, @offsets[1] - @offsets.shift)
      @header = ONIX::Header.from_xml(str)

    end

    # Iterate over all the products in an ONIX file
    #
    def each(&block)
      @offsets.each_with_index do |offset, idx|
        if idx + 1 < @offsets.size
          str = read_frag(@offsets[idx], @offsets[idx+1] - @offsets[idx])
          yield @product_klass.from_xml(str)
        end
      end
    end

    private

    def read_xml_attributes
      @input.seek(0)
      buf = @input.read(1024)
      m, @xml_version = *buf.match(/version="(.+)"/)
      @xml_version = @xml_version.to_f

      m, @encoding = *buf.match(/encoding="(.+)"/)
      @encoding = @encoding.to_s.downcase

      m, major, minor, rev = *buf.match(/.*onix\/(\d)\.(\d)\/(\d*).*/)
      @version = [major.to_i, minor.to_i, rev.to_i]
    end

    def read_offsets
      offsets = []
      @input.seek(0)
      while !@input.eof?
        buf = @input.read(14)
        @input.seek(-14, IO::SEEK_CUR)
        if buf[0,8] == "<Header>"
          offsets << @input.pos
        elsif buf[0,9] == "<Product>"
          offsets << @input.pos
        elsif buf[0,14] == "</ONIXMessage>"
          offsets << @input.pos
          return offsets
        end
        @input.seek(1, IO::SEEK_CUR)
      end
      offsets
    end

    def read_frag(offset, length)
      @input.seek(offset)
      @input.read(length)
    end
  end
end
