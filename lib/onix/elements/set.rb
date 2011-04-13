# coding: utf-8

class ONIX::Set < ONIX::Element
  xml_name "Set"
  onix_composite :product_identifiers, ONIX::ProductIdentifier
  xml_accessor :title_of_set, :from => "TitleOfSet"
  onix_composite :titles, ONIX::Title
  xml_accessor :set_part_number, :from => "SetPartNumber"
  xml_accessor :set_part_title, :from => "SetPartTitle"
  xml_accessor :number_within_set, :from => "ItemNumberWithinSet"
  xml_accessor :level_sequence_number, :from => "LevelSequenceNumber"
  xml_accessor :set_item_title, :from => "SetItemTitle"

  def initialize
    self.product_identifiers = []
    self.titles = []
  end
end
