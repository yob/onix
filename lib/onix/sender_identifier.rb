# coding: utf-8

module ONIX
  class SenderIdentifier
    include ROXML
    include ONIX::Common

    xml_name "SenderIdentifier"

    xml_accessor :sender_id_type, :from => "SenderIDType", :as => Fixnum, :to_xml => ONIX::Formatters.two_digit
    xml_accessor :id_type_name,   :from => "IDTypeName"
    xml_accessor :id_value,       :from => "IDValue"
  end
end
