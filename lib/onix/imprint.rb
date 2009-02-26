module ONIX
  class Imprint
    include ROXML

    xml_name "Imprint"

    xml_accessor :name_code_type,      :from => "NameCodeType", :as => Fixnum, :to_xml => ONIX::Formatters.two_digit
    xml_accessor :name_code_type_name, :from => "NameCodeTypeName"
    xml_accessor :name_code_value,     :from => "NameCodeValue"
    xml_accessor :imprint_name,        :from => "ImprintName"
  end
end
