require 'rexml/parsers/streamparser'
require 'thread'
require 'timeout'
require 'stringio'
require 'cgi'

module ONIX

  # a utility class for the ONIX Stream Reader. See ONIX::StreamReader for
  # basic usage instructions.
  class Listener

    def initialize(queue, product_klass = ::ONIX::Product)
      @queue = queue
      # TODO ensure product_class is ::ONIX::Product or ::ONIX::SimpleProduct
      @product_klass = product_klass
      @in_product = false
      @in_header = false
      @fragment = StringIO.new
    end

    def doctype(name, pub_sys, long_name, uri)
      # do nothing
    end

    def instruction(name, instruction)
      # do nothing
    end

    def tag_start(name, attrs)
      case name
      when "Header"
        @in_header = true
        @fragment = StringIO.new
        @fragment << "<Header>"
      when "Product"
        # A new product tag has been read, so start
        # building a new product to add to the queue
        @in_product = true
        @fragment = StringIO.new
        @fragment << "<Product>"
      else
        @fragment << "<#{name}>" if @in_product || @in_header
      end
    end

    def text(text)
      @fragment << CGI::escapeHTML(text) if @in_product || @in_header
    end

    def tag_end(name)
      case name
      when "ONIXMessage"
        # the ONIXMessage tag indicates the end of the file, so add
        # nil to the queue to let the iterating thread know reading
        # is finished
        @queue.push(nil)
      when "Header"
        # The header tag is finished, so add it to the queue
        @fragment << "</Header>"
        begin
          header = ONIX::Header.parse(@fragment.string)
          @queue.push(header) unless header.nil?
        rescue Exception => e
          # error occurred while building the product from an XML fragment
          # pop the error on the queue so it can be raised by the thread
          # reading items off the queue
          @queue.push(e)
        end
        @in_header = false
      when "Product"
        # A product tag is finished, so add it to the queue
        @fragment << "</Product>"
        begin
          product = @product_klass.parse(@fragment.string)
          @queue.push(product) unless product.nil?
        rescue Exception => e
          # error occurred while building the product from an XML fragment
          # pop the error on the queue so it can be raised by the thread
          # reading items off the queue
          @queue.push(e)
        end
        @in_product = false
      else
        @fragment << "</#{name}>" if @in_product || @in_header
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
  # returning a either a ONIX::Header or ONIX::Product object each time
  # it encounters </Header> or </Product>.
  #
  # == Basic usage
  #   require 'rbook/onix'
  #   reader = RBook::ONIX::StreamReader.new("some_onix_file.xml")
  #   reader.each do |item|
  #     case item
  #     when ONIX::Header
  #       puts "From Person: #{item.from_person}"
  #       puts "From Company: #{item.from_company}"
  #       puts "Date: #{item.sent_date}"
  #       puts
  #     else
  #       puts item.record_reference
  #     end
  #   end
  #
  # == Better Usage
  #
  # The problem with using ONIX::Product objects is they are the tip of a very
  # large and irritating iceberg. The designers of the ONIX spec attempted
  # to support all regional book industries around the world, so they included
  # everything except the kitchen sink. Obediently, ONIX::Product provides
  # access to it all.
  #
  # This can make even the most basic tasks quiet tedious. Take finding the 
  # products ISBN13 for example. A product record supports something like 15
  # different types of identifiers (ISBN, ISBN13, EAN, UPC, custom, etc). To
  # find the ISBN 13, you have to iterate over the array of IDs and look
  # for the one with the right ID Type Code (15 for an ISBN13):
  #
  #   isbn13 = product.product_identifiers.find { |id| id.product_id_type == 15 }
  #
  # A similar story exists for titles, subtitles, contributors, prices, 
  # cover images and descriptions!
  #
  # To hide all this complexity from your app, it's possible to write a proxy 
  # object that wraps each ONIX::Product object and simplifies access. This 
  # proxy object must extend ONIX::SimpleProduct. I've created on called
  # ONIX::APAProduct that offers simple access to the subset of the ONIX 
  # format that is used in the Australian market.
  # 
  # With this new class, reading an ONIX file with a StreamReader now looks
  # like this:
  #
  #   require 'rbook/onix'
  #   reader = RBook::ONIX::StreamReader.new("some_onix_file.xml", Onix::APAProduct)
  #   reader.each do |item|
  #     case item
  #     when ONIX::Header
  #       puts "From Person: #{item.from_person}"
  #       puts "From Company: #{item.from_company}"
  #       puts "Date: #{item.sent_date}"
  #       puts
  #     else
  #       puts "#{item.isbn13} - #{item.rrp_inc_sales_tax}"
  #       puts "#{item.title}"
  #       puts
  #     end
  #   end
  #
  # Basically very similar, but we pass in a second param to the StreamReader
  # constructor that tells it what class to return the products as.
  class StreamReader

    # creates a new stream reader to read the specified file.
    # file can be specified as a String or File object
    def initialize(input, product_klass = ::ONIX::Product)
      if input.kind_of? String
        @input = File.new(input)
      elsif input.kind_of?(File) || input.kind_of?(StringIO)
        @input = input
      else
        throw "Unable to read from path or file"
      end
      
      # TODO ensure product_class is ::ONIX::Product or ::ONIX::SimpleProduct

      # create a sized queue to store each product read from the file
      @queue = SizedQueue.new(100)

      # launch a reader thread to process the file and store each
      # product in the queue
      Thread.abort_on_exception = true
      Thread.new do
        producer = Listener.new(@queue, product_klass)
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
