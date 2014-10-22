# coding: utf-8

module ONIX2
  # The primary way to write a new ONIX file.
  #
  # Heres a quick example. The generated file will be nice and boring, as the
  # header and product objects have no data in them, but you get the idea.
  #
  #   File.open("output.xml","w") do |output|
  #     header = ONIX2::Header.new
  #     ONIX2::Writer.open(output, header) do |writer|
  #       writer << ONIX2::Product.new
  #       writer << ONIX2::Product.new
  #     end
  #   end
  #
  # If you prefer, you can build your products using the APAProduct shim layer.
  #
  #   File.open("output.xml","w") do |output|
  #     header = ONIX2::Header.new
  #     ONIX2::Writer.open(output, header) do |writer|
  #       writer << ONIX2::APAProduct.new
  #       writer << ONIX2::APAProduct.new
  #     end
  #   end
  #
  class Writer

    DOCTYPE = "http://www.editeur.org/onix/2.1/03/reference/onix-international.dtd"

    # Default constructor.
    def initialize(output, header)
      raise ArgumentError, 'msg must be an ONIX2::Header object' unless header.kind_of?(ONIX2::Header)
      @output = output
      @header = header
      @finished = false

      start_document
    end

    # deprecated
    def start_document
      puts "ONIX2::StreamWriter#start_document is no longer required"
    end

    def << (product)
      unless product.kind_of?(ONIX2::Product) || product.kind_of?(ONIX2::SimpleProduct)
        raise ArgumentError, 'product must be an ONIX2::Product or ONIX2::SimpleProduct'
      end
      raise "Can't add products to a finished writer" if finished?

      @output.write(product.to_xml.to_s)
      @output.write("\n")
    end

    def end_document
      @output.write("</ONIXMessage>\n")
      @finished = true
    end

    def finished?
      @finished
    end

    def self.open(output, header)
      if block_given?
        writer = self.new(output, header)
        yield writer
        writer.end_document
      else
        self.new(output, header)
      end
    end

    private

    def start_document
      @output.write("<?xml version=\"1.0\" encoding=\"utf-8\"?>\n")
      @output.write("<!DOCTYPE ONIXMessage SYSTEM \"#{DOCTYPE}\">\n")
      @output.write("<ONIXMessage release=\"2.1\">\n")
      @output.write(@header.to_xml.to_s)
      @output.write("\n")
    end

  end
end
