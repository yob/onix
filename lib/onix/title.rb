module ONIX
  class Title
    include XML::Mapping

    numeric_node :title_type, "TitleType"
    text_node    :title_text, "TitleText"
    text_node    :subtitle,   "Subtitle", :optional => true

  end
end
