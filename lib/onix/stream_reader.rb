require 'rexml/document'
require 'rexml/parsers/streamparser'
require 'thread'
require 'timeout'
require 'stringio'
require 'cgi'

module ONIX

  # a utility class for the ONIX Stream Reader. See ONIX::StreamReader for
  # basic usage instructions.
  class Listener

    def initialize(queue)
      @queue = queue
      @in_product = false
    end

    def doctype(name, pub_sys, long_name, uri)
      # do nothing
    end

    def instruction(name, instruction)
      # do nothing
    end

    def tag_start(name, attrs)
      case name
      when "Product"
        # A new product tag has been read, so start
        # building a new product to add to the queue
        @in_product = true
        @product_fragment = StringIO.new
        @product_fragment << "<Product>"
      else
        @product_fragment << "<#{name}>" if @in_product
      end
    end

    def text(text)
      @product_fragment << CGI::escapeHTML(text) if @in_product
    end

    def tag_end(name)
      case name
      when "ONIXMessage"
        # the ONIXMessage tag indicates the end of the file, so add
        # nil to the queue to let the iterating thread know reading
        # is finished
        @queue.push(nil)
      when "Product"
        # A product tag is finished, so add it to the queue
        @product_fragment << "</Product>"
        begin
          element = REXML::Document.new(@product_fragment.string).root
          product = ONIX::Product.load_from_xml(element)
          @queue.push(product) unless product.nil?
        rescue Exception => e
          # error occurred while building the product from an XML fragment
          # pop the error on the queue so it can be raised by the thread
          # reading items off the queue
          @queue.push(e)
        end
        @in_product = false
      else
        @product_fragment << "</#{name}>" if @in_product
      end
    end

    def xmldecl(version, encoding, standalone)
      # do nothing
    end

    def end_document
      # signal to the thread reading products off the queue that there are none left.
      # this event curently isn't supported by rexml, so if an ONIX file is truncated
      # and is missing </ONIXMessage>, it will hang. Patch submitted upstream
      @queue.push(nil)
    end

    def method_missing(*args)
      puts args.inspect
      # do nothing
    end
  end

  # A stream reader for ONIX files. Using a stream reader is preferred for
  # large XML files as the file is processed in stages, removing the need
  # to store the entire thing in memory at once.
  #
  # This class provides forward only iteration over a single ONIX file,
  # returning a RBook::ONIX::Product object for each product encountered.
  #
  # = Basic usage
  #  require 'rbook/onix'
  #  reader = RBook::ONIX::StreamReader.new("some_onix_file.xml")
  #  reader.each do |product|
  #    puts product.inspect
  #  end
  class StreamReader

    # creates a new stream reader to read the specified file.
    # file can be specified as a String or File object
    def initialize(input)
      if input.kind_of? String
        @input = File.new(input)
      elsif input.kind_of?(File) || input.kind_of?(StringIO)
        @input = input
      else
        throw "Unable to read from path or file"
      end

      # create a sized queue to store each product read from the file
      @queue = SizedQueue.new(100)

      # launch a reader thread to process the file and store each
      # product in the queue
      Thread.new do
        producer = Listener.new(@queue)
        parser = REXML::Parsers::StreamParser.new(@input, producer)
        parser.parse
      end
    end

    # iterate over the file and return a product file to a block.
    #
    #  reader = RBook::ONIX::StreamReader.new("some_onix_file.xml")
    #  reader.each do |product|
    #    puts product.inspect
    #  end
    def each
      # if the ONIX file we're processing has been truncated (no </ONIXMessage>), then
      # we will block on the next @queue.pop indefinitely, so give it a time limit
      obj = nil
      Timeout::timeout(2) { obj = @queue.pop }
      while !obj.nil?
        raise obj if obj.kind_of?(Exception)
        yield obj

        Timeout::timeout(2) { obj = @queue.pop }
      end
    rescue Timeout::Error
      # do nothing, no more items on the queue - possibly the source
      # file wasn't an XML file?
    end
  end
end
