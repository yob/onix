module ONIX
  class OtherText
    include XML::Mapping

    numeric_node :text_type_code, "TextTypeCode"
    numeric_node :text_format,    "TextFormat",   :optional => true
    text_node    :text,           "Text",         :optional => true
    numeric_node :text_link_type, "TextLinkType", :optional => true
    text_node    :text_link,      "TextLink",     :optional => true
    text_node    :text_author,    "TextAuthor",   :optional => true
  end
end
