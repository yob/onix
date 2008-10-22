module ONIX
  class Title
    include ROXML 

    xml_accessor :title_type, :twodigit, :from => "TitleType"
    xml_accessor :title_text,            :from => "TitleText"
    xml_accessor :subtitle,              :from => "Subtitle"

  end
end
