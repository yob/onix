module ONIX
  class OtherText
    include ROXML

    xml_accessor :text_type_code, :from => "TextTypeCode", :as => Fixnum # should be a 2 digit num
    xml_accessor :text_format,    :from => "TextFormat"
    xml_accessor :text,           :from => "Text"
    xml_accessor :text_link_type, :from => "TextLinkType", :as => Fixnum # should be a 2 digit num
    xml_accessor :text_link,      :from => "TextLink"
    xml_accessor :text_author,    :from => "TextAuthor"
  end
end
