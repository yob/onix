# coding: utf-8

class ONIX::Conference < ONIX::Element
  xml_name "Conference"
  onix_code_from_list :conference_role, "ConferenceRole", :list => 20
  xml_accessor :conference_name, :from => "ConferenceName"
  xml_accessor :conference_acronym, :from => "ConferenceAcronym"
  xml_accessor :conference_number, :from => "ConferenceNumber"
  xml_accessor :conference_theme, :from => "ConferenceTheme"
  xml_accessor :conference_date, :from => "ConferenceDate"
  xml_accessor :conference_place, :from => "ConferencePlace"
  onix_composite :conference_sponsors, ONIX::ConferenceSponsor
  onix_composite :websites, ONIX::Website
end
