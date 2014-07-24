# coding: utf-8

module ONIX
  class AddresseeIdentifier
    include ROXML

    xml_name "AddresseeIdentifier"

    xml_accessor :addressee_id_type, :from => "AddresseeIDType", :as => Fixnum, :to_xml => ONIX::Formatters.two_digit
    xml_accessor :id_type_name,      :from => "IDTypeName"
    xml_accessor :id_value,          :from => "IDValue"
  end
end
