module ONIX
  class OtherText
    include ROXML

    xml_name "OtherText"

    xml_accessor :text_type_code, :from => "TextTypeCode", :as => Fixnum, :to_xml => ONIX::Formatters.two_digit
    xml_accessor :text_format,    :from => "TextFormat"
    xml_accessor :text,           :from => "Text"
    xml_accessor :text_link_type, :from => "TextLinkType", :as => Fixnum, :to_xml => ONIX::Formatters.two_digit
    xml_accessor :text_link,      :from => "TextLink"
    xml_accessor :text_author,    :from => "TextAuthor"
  end
end
