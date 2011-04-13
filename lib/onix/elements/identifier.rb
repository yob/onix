# coding: utf-8

class ONIX::Identifier < ONIX::Element
  xml_accessor :id_value, :from => "IDValue"
  # Optional, only used if x_id_type indicates a proprietary id scheme.
  xml_accessor :id_type_name, :from => "IDTypeName"
end
