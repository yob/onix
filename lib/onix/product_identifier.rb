module ONIX
  class ProductIdentifier
    include XML::Mapping

    two_digit_node :product_id_type, "ProductIDType"
    text_node      :id_value,        "IDValue"
  end
end
