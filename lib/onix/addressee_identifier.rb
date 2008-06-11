module ONIX
  class AddresseeIdentifier
    include XML::Mapping

    numeric_node :addressee_id_type, "AddresseeIDType"
    text_node    :id_type_name,      "IDTypeName", :optional => true
    text_node    :id_value,          "IDValue"
  end
end
