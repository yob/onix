module ONIX
  class Title
    include ROXML 

    xml_accessor :title_type, :from => "TitleType", :as => Fixnum # should be a 2 digit num
    xml_accessor :title_text, :from => "TitleText"
    xml_accessor :subtitle,   :from => "Subtitle"

  end
end
