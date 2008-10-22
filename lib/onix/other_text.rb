module ONIX
  class OtherText
    include ROXML

    xml_accessor :text_type_code, :twodigit, :from => "TextTypeCode"
    xml_accessor :text_format, :from => "TextFormat"
    xml_accessor :text, :from => "Text"
    xml_accessor :text_link_type, :twodigit, :from => "TextLinkType"
    xml_accessor :text_link, :from => "TextLink"
    xml_accessor :text_author, :from => "TextAuthor"
  end
end
