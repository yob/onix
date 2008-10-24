module ONIX
  class Contributor
    include ROXML

    xml_accessor :sequence_number,      :from => "SequenceNumber"
    xml_accessor :contributor_role,     :from => "ContributorRole"
    xml_accessor :language_code,        :from => "LanguageCode"
    xml_accessor :sequence_number_within_role,  :from => "SequenceNumberWithinRole"
    xml_accessor :person_name,          :etext, :from => "PersonName"
    xml_accessor :person_name_inverted, :etext, :from => "PersonNameInverted"
    xml_accessor :titles_before_name,   :etext, :from => "TitlesBeforeName"
    xml_accessor :names_before_key,     :etext, :from => "NamesBeforeKey"
    xml_accessor :prefix_to_key,        :etext, :from => "PrefixToKey"
    xml_accessor :key_names,            :etext, :from => "KeyNames"
    xml_accessor :names_after_key,      :etext, :from => "NamesArterKey"
    xml_accessor :suffix_to_key,        :etext, :from => "SuffixToKey"
    xml_accessor :letters_after_names,  :etext, :from => "LettersAfterNames"
    xml_accessor :titles_after_names,   :etext, :from => "TitlesAfterNames"
  end
end
