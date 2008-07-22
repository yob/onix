module ONIX
  class Imprint
    include XML::Mapping

    two_digit_node :name_code_type,      "NameCodeType", :optional => true
    text_node      :name_code_type_name, "NameCodeTypeName", :optional => true
    text_node      :name_code_value,     "NameCodeValue", :optional => true
    text_node      :imprint_name,        "ImprintName", :optional => true
  end
end
