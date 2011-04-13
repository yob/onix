# coding: utf-8

class ONIX::ProfessionalAffiliation < ONIX::Element
  xml_name "ProfessionalAffiliation"
  xml_accessor :professional_position, :from => "ProfessionalPosition"
  xml_accessor :affiliation, :from => "Affiliation"
end
