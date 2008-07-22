module ONIX
  class Title
    include XML::Mapping

    two_digit_node :title_type, "TitleType"
    text_node      :title_text, "TitleText"
    text_node      :subtitle,   "Subtitle", :optional => true

  end
end
