# coding: utf-8

class ONIX::ConferenceSponsor < ONIX::Element
  xml_name "ConferenceSponsor"
  onix_composite :conference_sponsor_identifiers, ONIX::ConferenceSponsorIdentifier
  xml_accessor :person_name, :from => "PersonName"
  xml_accessor :corporate_name, :from => "CorporateName"

  def initialize
    self.conference_sponsor_identifiers = []
  end
end
