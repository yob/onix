module ONIX
  class Title
    include ROXML 

    xml_accessor :title_type, :twodigit, :from => "TitleType"
    xml_accessor :title_text, :etext,    :from => "TitleText"
    xml_accessor :subtitle,   :etext,    :from => "Subtitle"

  end
end
