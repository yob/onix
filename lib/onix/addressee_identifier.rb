# coding: utf-8

module ONIX
  class AddresseeIdentifier
    include ROXML
    include ONIX::Common

    xml_accessor :addressee_id_type, :from => "AddresseeIDType", :as => Fixnum # should be a 2 digit num
    xml_accessor :id_type_name,      :from => "IDTypeName"
    xml_accessor :id_value,          :from => "IDValue"
  end
end
