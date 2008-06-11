module ONIX
  class SenderIdentifier
    include XML::Mapping

    numeric_node :sender_id_type, "SenderIDType"
    text_node    :id_type_name,   "IDTypeName", :optional => true
    text_node    :id_value,       "IDValue"
  end
end
