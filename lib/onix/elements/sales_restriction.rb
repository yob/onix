# coding: utf-8

module ONIX
  class SalesRestriction < ONIX::Element
    xml_name "SalesRestriction"

    xml_accessor :sales_restriction_type, :from =>"SalesRestrictionType", :as => Fixnum, :to_xml => ONIX::Formatters.two_digit
  end
end
