# coding: utf-8

class ONIX::Complexity < ONIX::Element
  xml_name "Complexity"
  onix_code_from_list :complexity_scheme_identifier, "ComplexitySchemeIdentifier", :list => 32
  xml_accessor :complexity_code, :from => "ComplexityCode"
end
