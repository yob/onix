module ONIX
  class Imprint
    include ROXML

    xml_accessor :name_code_type, :from => "NameCodeType"
    xml_accessor :name_code_type_name, :from => "NameCodeTypeName"
    xml_accessor :name_code_value, :from => "NameCodeValue"
    xml_accessor :imprint_name, :from => "ImprintName"
  end
end
