# coding: utf-8

class ONIX::ContentItem < ONIX::Element
  xml_name "ContentItem"
  xml_accessor :level_sequence_number, :from => "LevelSequenceNumber"
  onix_composite :text_item, ONIX::TextItem
  onix_composite :website, ONIX::Website
  xml_accessor :component_type_name, :from => "ComponentTypeName"
  xml_accessor :component_number, :from => "ComponentNumber"
  xml_accessor :distinctive_title, :from => "DistinctiveTitle"
  onix_composite :titles, ONIX::Title
  onix_composite :work_identifiers, ONIX::WorkIdentifier
  onix_composite :contributors, ONIX::Contributor
  xml_accessor :contributor_statement, :from => "ContributorStatement"
  onix_composite :subjects, ONIX::Subject
  onix_composite :person_as_subjects, ONIX::Contributor
  xml_accessor :corporate_body_as_subject, :from => "CorporateBodyAsSubject", :as => []
  xml_accessor :place_as_subject, :from => "PlaceAsSubject", :as => []
  onix_composite :other_texts, ONIX::OtherText
  onix_composite :media_files, ONIX::MediaFile
end
