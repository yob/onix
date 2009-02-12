module ONIX
  class Website
    include ROXML

    xml_accessor :website_role,        :from => "WebsiteRole", :as => Integer # should be a 2 digit num
    xml_accessor :website_description, :from => "WebsiteDescription"
    xml_accessor :website_link,        :from => "WebsiteLink"
  end
end
