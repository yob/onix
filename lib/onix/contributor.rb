# coding: utf-8

module ONIX
  class Contributor
    include ROXML

    xml_name "Contributor"

    xml_accessor :sequence_number,      :from => "SequenceNumber", :as => Fixnum
    xml_accessor :contributor_role,     :from => "ContributorRole"
    xml_accessor :language_code,        :from => "LanguageCode"
    xml_accessor :sequence_number_within_role,  :from => "SequenceNumberWithinRole", :as => Fixnum
    xml_accessor :person_name,          :from => "PersonName"
    xml_accessor :person_name_inverted, :from => "PersonNameInverted"
    xml_accessor :titles_before_names,  :from => "TitlesBeforeNames"
    xml_accessor :names_before_key,     :from => "NamesBeforeKey"
    xml_accessor :prefix_to_key,        :from => "PrefixToKey"
    xml_accessor :key_names,            :from => "KeyNames"
    xml_accessor :names_after_key,      :from => "NamesArterKey"
    xml_accessor :suffix_to_key,        :from => "SuffixToKey"
    xml_accessor :letters_after_names,  :from => "LettersAfterNames"
    xml_accessor :titles_after_names,   :from => "TitlesAfterNames"
    xml_accessor :corporate_name,       :from => "CorporateName"
    xml_accessor :biographical_note,    :from => "BiographicalNote"
  end
end
