# coding: utf-8

class ONIX::Publisher < ONIX::Element
  xml_name "Publisher"
  onix_code_from_list :publishing_role, "PublishingRole", :list => 45
  onix_code_from_list :name_code_type, "NameCodeType", :list => 44
  xml_accessor :name_code_type_name, :from => "NameCodeTypeName"
  xml_accessor :name_code_type_value, :from => "NameCodeTypeValue"
  xml_accessor :publisher_name, :from => "PublisherName"
  onix_composite :websites, ONIX::Website
end
