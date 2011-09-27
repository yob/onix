# coding: utf-8

class ONIX::OtherText < ONIX::Element
  xml_name "OtherText"
  onix_code_from_list :text_type_code, "TextTypeCode", :list => 33
  onix_code_from_list :text_format, "TextFormat", :list => 34
  xml_accessor :text_format, :from => "TextFormat"
  xml_accessor :text, :from => "Text"
  onix_code_from_list :text_link_type, "TextLinkType", :list => 35
  xml_accessor :text_link, :from => "TextLink"
  xml_accessor :text_author, :from => "TextAuthor"
  xml_accessor :text_source_corporate, :from => "TextSourceCorporate"
  xml_accessor :text_source_title, :from => "TextSourceTitle"
  onix_date_accessor :text_publication_date, "TextPublicationDate"
  onix_date_accessor :start_date, "StartDate"
  onix_date_accessor :end_date, "EndDate"
end
