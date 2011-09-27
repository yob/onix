# coding: utf-8

class ONIX::Imprint < ONIX::Element
  xml_name "Imprint"
  onix_code_from_list :name_code_type, "NameCodeType", :list => 44
  xml_accessor :name_code_type_name, :from => "NameCodeTypeName"
  xml_accessor :name_code_value, :from => "NameCodeValue"
  xml_accessor :imprint_name, :from => "ImprintName"
end
