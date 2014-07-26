# coding: utf-8

module ONIX
  class Contributor
    include Virtus.model

    attribute :sequence_number, Integer
    attribute :contributor_role
    attribute :language_code
    attribute :sequence_number_within_role, Integer
    attribute :person_name
    attribute :person_name_inverted
    attribute :titles_before_names
    attribute :names_before_key
    attribute :prefix_to_key
    attribute :key_names
    attribute :names_after_key
    attribute :suffix_to_key
    attribute :letters_after_names
    attribute :titles_after_names
    attribute :corporate_name
    attribute :biographical_note

    def to_xml
      ContributorRepresenter.new(self).to_xml
    end

    def self.from_xml(data)
      ContributorRepresenter.new(self.new).from_xml(data)
    end
  end

class ContributorRepresenter < Representable::Decorator
    include Representable::XML

    self.representation_wrap = :Contributor

    property :sequence_number, as: "SequenceNumber"
    property :contributor_role, as: "ContributorRole"
    property :language_code, as: "LanguageCode"
    property :sequence_number_within_role, as: "SequenceNumberWithinRole"
    property :person_name, as: "PersonName"
    property :person_name_inverted, as: "PersonNameInverted"
    property :titles_before_names, as: "TitlesBeforeNames"
    property :names_before_key, as: "NamesBeforeKey"
    property :prefix_to_key, as: "PrefixToKey"
    property :key_names, as: "KeyNames"
    property :names_after_key, as: "NamesArterKey"
    property :suffix_to_key, as: "SuffixToKey"
    property :letters_after_names, as: "LettersAfterNames"
    property :titles_after_names, as: "TitlesAfterNames"
    property :corporate_name, as: "CorporateName"
    property :biographical_note, as: "BiographicalNote"
  end
end
