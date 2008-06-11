module ONIX
  class ProductIdentifier
    include XML::Mapping

    numeric_node :product_id_type, "ProductIDType"
    text_node :id_value,           "IDValue"
  end
end
