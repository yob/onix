module ONIX
  class AddresseeIdentifier
    include ROXML

    xml_accessor :addressee_id_type, :twodigit, :from => "AddresseeIDType"
    xml_accessor :id_type_name,      :from => "IDTypeName"
    xml_accessor :id_value,          :from => "IDValue"
  end
end
