module ONIX
  class Imprint
    include ROXML

    xml_accessor :name_code_type,      :from => "NameCodeType", :as => Integer # should be a 2 digit num
    xml_accessor :name_code_type_name, :from => "NameCodeTypeName"
    xml_accessor :name_code_value,     :from => "NameCodeValue"
    xml_accessor :imprint_name,        :from => "ImprintName"
  end
end
