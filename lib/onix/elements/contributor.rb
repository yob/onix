# coding: utf-8

class ONIX::Contributor < ONIX::NameBase
  xml_name "Contributor"
  xml_accessor :sequence_number, :from => "SequenceNumber", :as => Fixnum
  onix_code_from_list :contributor_role, "ContributorRole", :list => 17
  onix_code_from_list :language_code, "LanguageCode", :list => 74
  xml_accessor :sequence_number_within_role, :from => "SequenceNumberWithinRole", :as => Fixnum
  onix_composite :names, ONIX::Name
  onix_composite :person_dates, ONIX::PersonDate
  onix_composite :professional_affiliations, ONIX::ProfessionalAffiliation
  xml_accessor :corporate_name, :from => "CorporateName"
  xml_accessor :biographical_note, :from => "BiographicalNote"
  onix_composite :websites, ONIX::Website
  xml_accessor :contributor_description, :from => "ContributorDescription"
  onix_code_from_list :unnamed_persons, "UnnamedPersons", :list => 19
  onix_code_from_list :country_code, "CountryCode", :list => 91
  onix_code_from_list :region_code, "RegionCode", :list => 49 # FIXME: don't enforce
end
