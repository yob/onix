# coding: utf-8

class ONIX::Contributor < ONIX::Element
  xml_name "Contributor"
  xml_accessor :sequence_number, :from => "SequenceNumber", :as => Fixnum
  onix_code_from_list :contributor_role, "ContributorRole", :list => 17
  onix_code_from_list :language_code, "LanguageCode", :list => 74
  xml_accessor :sequence_number_within_role, :from => "SequenceNumberWithinRole", :as => Fixnum
  # FIXME: same fields are used in <Name>: -------[
  xml_accessor :person_name, :from => "PersonName"
  xml_accessor :person_name_inverted, :from => "PersonNameInverted"
  xml_accessor :titles_before_names, :from => "TitlesBeforeNames"
  xml_accessor :names_before_key, :from => "NamesBeforeKey"
  xml_accessor :prefix_to_key, :from => "PrefixToKey"
  xml_accessor :key_names, :from => "KeyNames"
  xml_accessor :names_after_key, :from => "NamesAfterKey"
  xml_accessor :suffix_to_key, :from => "SuffixToKey"
  xml_accessor :letters_after_names, :from => "LettersAfterNames"
  xml_accessor :titles_after_names, :from => "TitlesAfterNames"
  onix_composite :person_name_identifiers, ONIX::PersonNameIdentifier
  # ]-------
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

  def initialize
    self.person_name_identifiers = []
    self.names = []
    self.person_dates = []
    self.professional_affiliations = []
    self.websites = []
  end
end
