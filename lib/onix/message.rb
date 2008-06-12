require 'stringio'

module ONIX
  class Message
    include XML::Mapping

    ONIX_DTD_URL = "http://www.editeur.org/onix/2.1/reference/onix-international.dtd"

    root_element_name "ONIXMessage"

    object_node :header,   "Header",  :class => ONIX::Header
    array_node  :products, "Product", :class => ONIX::Product

    def initialize
      self.products = []
    end

    def to_stringio
      write(StringIO.new)
    end

    def write(io)
      formatter = REXML::Formatters::Default.new(2)

      decl = REXML::XMLDecl.new
      doctype = REXML::DocType.new('ONIXMessage', "SYSTEM \"#{ONIX::Message::ONIX_DTD_URL}\"")
      decl.encoding = "utf-8"
      io.write(decl.to_s+"\n")
      io.write(doctype.to_s+"\n")

      formatter.write(self.save_to_xml, io)
      io
    end
  end
end
