module ONIX
  class Website
    include ROXML

    xml_accessor :website_role,        :from => "WebsiteRole"
    xml_accessor :website_description, :from => "WebsiteDescription"
    xml_accessor :website_link,        :from => "WebsiteLink"
  end
end
