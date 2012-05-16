# coding: utf-8

class ONIX::DiscountCoded < ONIX::Element
  xml_name "DiscountCoded"
  onix_code_from_list :discount_code_type, "DiscountCodeType", :list => 100
  xml_accessor :discount_code_type_name, :from => "DiscountCodeTypeName"
  xml_accessor :discount_code
end
