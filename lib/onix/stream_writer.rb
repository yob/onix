require 'rexml/document'

module ONIX
  class StreamWriter

    # Default constructor.
    def initialize(output, header, encoding = "utf-8")
      raise ArgumentError, 'msg must be an ONIX::Message object' unless header.kind_of?(ONIX::Header)
      @output = output
      @header = header
      @formatter = REXML::Formatters::Pretty.new(2)

      start_document encoding
    end

    def << (product)
      raise ArgumentError, 'product must be an ONIX::Product object' unless product.kind_of?(ONIX::Product)
      @formatter.write(product.save_to_xml, @output)
    end

    def end_document
      @output.write("\n</ONIXMessage>\n")
    end

    private

    def start_document(encoding)
      decl = REXML::XMLDecl.new
      doctype = REXML::DocType.new('ONIXMessage', "SYSTEM \"#{ONIX::Message::ONIX_DTD_URL}\"")
      decl.encoding = encoding
      @output.write(decl.to_s+"\n")
      @output.write(doctype.to_s+"\n")
      @output.write("<ONIXMessage>\n")
      @formatter.write(@header.save_to_xml, @output)
    end

  end
end
