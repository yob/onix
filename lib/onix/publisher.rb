module ONIX
  class Publisher
    include XML::Mapping

    numeric_node :publishing_role,      "PublishingRole", :optional => true
    numeric_node :name_code_type,       "NameCodeType", :optional => true
    text_node    :name_code_type_name,  "NameCodeTypeName", :optional => true
    text_node    :name_code_type_value, "NameCodeTypeValue", :optional => true
    text_node    :publisher_name,       "PublisherName", :optional => true
  end
end
