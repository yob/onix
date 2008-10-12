module ONIX
  class SenderIdentifier
    include ROXML

    xml_accessor :sender_id_type, :from => "SenderIDType"
    xml_accessor :id_type_name,   :from => "IDTypeName"
    xml_accessor :id_value,       :from => "IDValue"
  end
end
