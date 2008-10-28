require 'thread'
require 'timeout'
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

    attr_reader :header, :version, :xml_lang, :xml_version, :encoding

    # Create a new ONIX::Reader object
    #
    def initialize(input, product_klass = ::ONIX::Product)
      if input.kind_of? String
        @reader = LibXML::XML::Reader.file(input)
      elsif input.kind_of?(IO)
        @reader = LibXML::XML::Reader.io(input)
      else
        throw "Unable to read from path or file"
      end

      @product_klass = product_klass

      # create a sized queue to store each product read from the file
      @queue = SizedQueue.new(100)

      # launch a reader thread to process the file and store each
      # product in the queue
      Thread.abort_on_exception = true
      Thread.new { read_input }

      while @queue.size == 0
        sleep 0.05
      end
    end

    # Iterate over all the products in an ONIX file
    #
    def each(&block)
      obj = @queue.pop
      while !obj.nil?
        yield obj
        obj = @queue.pop
      end
    end

    private

    # Walk the ONIX file, and grab the bits we're interested in.
    #
    # High level attributes and the header are stored as attributes of the reader
    # class. Products are placed in a queue, ready to be popped off when the
    # user uses the each() method.
    #
    def read_input
      while @reader.read == 1
        @xml_lang    = @reader.xml_lang         if @xml_lang.nil?
        @xml_version = @reader.xml_version.to_f if @xml_version.nil?
        @encoding    = @reader.encoding         if @encoding.nil?
        if @reader.node_type == 10
          uri = @reader.expand.to_s
          m, major, minor, rev = *uri.match(/.+(\d)\.(\d)\/(\d*).*/)
          @version = [major.to_i, minor.to_i, rev.to_i]
        elsif @reader.name == "Header" && @reader.node_type == 1
          @header = ONIX::Header.parse(@reader.expand.to_s)
          @reader.next_sibling
        elsif @reader.name == "Product" && @reader.node_type == 1
          node = @reader.expand
          @queue.push @product_klass.parse(node.to_s)
          @reader.next_sibling
        end
      end
      @queue.push nil
    end
  end
end
