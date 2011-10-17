# coding: utf-8

class ONIX::Illustrations < ONIX::Element
  xml_name "Illustrations"
  onix_code_from_list :illustration_type, "IllustrationType", :list => 25
  xml_accessor :illustration_type_description, :from => "IllustrationTypeDescription"
  xml_accessor :number, :from => "Number", :as => Fixnum
end
