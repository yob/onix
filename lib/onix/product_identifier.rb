# coding: utf-8

module ONIX
  class ProductIdentifier
    include ROXML
    include ONIX::Common

    xml_name "ProductIdentifier"

    xml_accessor :product_id_type, :from => "ProductIDType", :as => Fixnum, :to_xml => ONIX::Formatters.two_digit
    xml_accessor :id_value, :from => "IDValue"
  end
end
