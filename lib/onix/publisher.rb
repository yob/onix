module ONIX
  class Publisher
    include ROXML

    xml_accessor :publishing_role,      :twodigit, :from => "PublishingRole"
    xml_accessor :name_code_type,       :twodigit, :from => "NameCodeType"
    xml_accessor :name_code_type_name,  :etext,    :from => "NameCodeTypeName"
    xml_accessor :name_code_type_value, :etext,    :from => "NameCodeTypeValue"
    xml_accessor :publisher_name,       :etext,    :from => "PublisherName"
  end
end
