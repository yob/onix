require 'stringio'

module ONIX
  # This class is the easiest, but probably not the best way to read and build
  # ONIX files.
  #
  # A ONIX::Message object is composed of 1 ONIX::Header object and 0 or more
  # ONIX::Product object. Each Header and Product object has a range of getters 
  # and setters that directly map to specific XML tags in the ONIX spec.
  #
  # For example, the <Header> tag in the spec has a range of sub tags, like 
  # <FromPerson>. Therefore, the ONIX::Header object will have a corresponding
  # getter and setter: header.from_person and header.from_person=.
  #
  # I recommend *not* using the following 2 methods of reading and writing
  # ONIX files. The mainly exist as low level plumbing and as a side effect
  # of this libraries dependencies. Look at ONIX::StreamReader and 
  # ONIX::StreamWriter for an improved method.
  #
  # = Reading
  #
  #   msg = ONIX::Message.load_from_file("somefile.xml")
  #   puts msg.header.inspect
  #   msg.products.each do |product|
  #     puts product.inspect
  #   end
  #
  # = Writing
  #
  #   msg = ONIX::Message.new
  #   header = ONIX::Header.new 
  #   header.from_person = "James Healy"
  #   header.from_company = "Acme Co."
  #   msg.header = header
  #   
  #   product = ONIX::Product.new
  #   product.record_reference = "1"
  #   product.isbn13 = "9781599471440"
  #   product.title = "Aging in the Church"
  #   product.subtitle = "How social relationships affect health"
  #   msg.products << product
  #
  #   puts msg.to_s
  class Message
    include XML::Mapping

    ONIX_DTD_URL = "http://www.editeur.org/onix/2.1/reference/onix-international.dtd"

    root_element_name "ONIXMessage"

    object_node :header,   "Header",  :class => ONIX::Header
    array_node  :products, "Product", :class => ONIX::Product

    # create a new onix message
    def initialize
      self.products = []
    end

    # build this message into an XML string
    def to_s
      to_stringio.string
    end

    # build this message into an XML StringIO object
    def to_stringio
      write(StringIO.new)
    end

    # build this message into an XML and write it to the specified IO stream
    # 
    #   File.open("somefile.xml","w") do |output|
    #     msg.write(output)
    #   end
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
