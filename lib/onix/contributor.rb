module ONIX
  class Contributor
    include XML::Mapping

    numeric_node :sequence_number,      "SequenceNumber", :optional => true
    text_node    :contributor_role,     "ContributorRole", :optional => true
    text_node    :language_code,        "LanguageCode", :optional => true
    numeric_node :sequence_number_within_role, "SequenceNumberWithinRole", :optional => true
    text_node    :person_name,          "PersonName", :optional => true
    text_node    :person_name_inverted, "PersonNameInverted", :optional => true
    text_node    :titles_before_name,   "TitlesBeforeName", :optional => true
    text_node    :names_before_key,     "NamesBeforeKey", :optional => true
    text_node    :prefix_to_key,        "PrefixToKey", :optional => true
    text_node    :key_names,            "KeyNames", :optional => true
    text_node    :names_after_key,      "NamesArterKey", :optional => true
    text_node    :suffix_to_key,        "SuffixToKey", :optional => true
    text_node    :letters_after_names,  "LettersAfterNames", :optional => true
    text_node    :titles_after_names,   "TitlesAfterNames", :optional => true
  end
end
