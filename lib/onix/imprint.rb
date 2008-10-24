module ONIX
  class Imprint
    include ROXML

    xml_accessor :name_code_type,      :twodigit, :from => "NameCodeType"
    xml_accessor :name_code_type_name, :etext,    :from => "NameCodeTypeName"
    xml_accessor :name_code_value,     :etext,    :from => "NameCodeValue"
    xml_accessor :imprint_name,        :etext,    :from => "ImprintName"
  end
end
