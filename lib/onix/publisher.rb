module ONIX
  class Publisher
    include ROXML

    xml_accessor :publishing_role,      :from => "PublishingRole"
    xml_accessor :name_code_type,       :from => "NameCodeType"
    xml_accessor :name_code_type_name,  :from => "NameCodeTypeName"
    xml_accessor :name_code_type_value, :from => "NameCodeTypeValue"
    xml_accessor :publisher_name,       :from => "PublisherName"
  end
end
