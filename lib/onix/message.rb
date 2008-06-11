module ONIX
  class Message
    include XML::Mapping

    object_node :header,   "Header",  :class => ONIX::Header
    array_node  :products, "Product", :class => ONIX::Product
  end
end
