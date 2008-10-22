module ONIX
  class Writer

    DOCTYPE = "http://www.editeur.org/onix/2.1/03/reference/onix-international.dtd"

    # Default constructor.
    def initialize(output, header)
      raise ArgumentError, 'msg must be an ONIX::Header object' unless header.kind_of?(ONIX::Header)
      @output = output
      @header = header

      start_document
    end

    # deprecated
    def start_document
      puts "ONIX::StreamWriter#start_document is no longer required"
    end

    def << (product)
      unless product.kind_of?(ONIX::Product) || product.kind_of?(ONIX::SimpleProduct)
        raise ArgumentError, 'product must be an ONIX::Product or ONIX::SimpleProduct'
      end
      @output.write(product.to_xml.to_s)
      @output.write("\n")
    end

    def end_document
      @output.write("</ONIXMessage>\n")
    end

    private

    def start_document
      decl = REXML::XMLDecl.new
      doctype = REXML::DocType.new('ONIXMessage', "SYSTEM \"#{DOCTYPE}\"")
      decl.encoding = "utf-8"
      @output.write(decl.to_s+"\n")
      @output.write(doctype.to_s+"\n")
      @output.write("<ONIXMessage>\n")
      @output.write(@header.to_xml.to_s)
      #@formatter.write(@header.to_xml, @output)
      @output.write("\n")
    end

  end
end
