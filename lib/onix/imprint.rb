# coding: utf-8

module ONIX
  class Imprint
    include ROXML

    xml_name "Imprint"

    xml_accessor :name_code_type,      :from => "NameCodeType", :as => Fixnum, :to_xml => ONIX::Formatters.two_digit
    xml_accessor :name_code_type_name, :from => "NameCodeTypeName"
    xml_accessor :name_code_value,     :from => "NameCodeValue"
    xml_accessor :imprint_name,        :from => "ImprintName"
  end

  module ImprintRepresenter
    include Representable::XML

    self.representation_wrap = :Imprint

    property :name_code_type, as: "NameCodeType", getter: lambda { |arg| "%02i" % name_code_type if name_code_type.present? }
    property :name_code_type_name, as: "NameCodeTypeName"
    property :name_code_value, as: "NameCodeValue"
    property :imprint_name, as: "ImprintName"
  end
end
