module ONIX
  class Message
    include XML::Mapping

    ONIX_DTD_URL = "http://www.editeur.org/onix/2.1/reference/onix-international.dtd"

    object_node :header,   "Header",  :class => ONIX::Header
    array_node  :products, "Product", :class => ONIX::Product
  end
end
