# coding: utf-8

class ONIX::Audience < ONIX::Element
  xml_name "Audience"
  onix_code_from_list :audience_code_type, "AudienceCodeType", :list => 29
  xml_accessor :audience_code_type_name, "AudienceCodeTypeName"
  xml_accessor :audience_code_value, "AudienceCodeValue"
end
