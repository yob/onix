require 'rexml/document'

module ONIX
  class StreamWriter

    # Default constructor.
    def initialize(output, header)
      raise ArgumentError, 'msg must be an ONIX::Header object' unless header.kind_of?(ONIX::Header)
      @output = output
      @header = header
      @formatter = REXML::Formatters::Default.new(2)

      start_document
    end

    def << (product)
      unless product.kind_of?(ONIX::Product) || product.kind_of?(ONIX::SimpleProduct)
        raise ArgumentError, 'product must be an ONIX::Product or ONIX::SimpleProduct' 
      end
      @formatter.write(product.save_to_xml, @output)
    end

    def end_document
      @output.write("\n</ONIXMessage>\n")
    end

    private

    def start_document
      decl = REXML::XMLDecl.new
      doctype = REXML::DocType.new('ONIXMessage', "SYSTEM \"#{ONIX::Message::ONIX_DTD_URL}\"")
      decl.encoding = "utf-8"
      @output.write(decl.to_s+"\n")
      @output.write(doctype.to_s+"\n")
      @output.write("<ONIXMessage>\n")
      @formatter.write(@header.save_to_xml, @output)
    end

  end
end
