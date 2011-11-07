# coding: utf-8

module ONIX
  class DiscountCoded
    include ROXML

    xml_name "DiscountCoded"

    xml_accessor :discount_code_type, :from => "DiscountCodeType", :as => Fixnum, :to_xml => ONIX::Formatters.two_digit
    xml_accessor :discount_code_type_name, :from => "DiscountCodeTypeName"
    xml_accessor :discount_code, :from => "DiscountCode"
  end
end
