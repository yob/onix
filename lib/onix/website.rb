module ONIX
  class Website
    include ROXML

    xml_name "Website"

    xml_accessor :website_role,        :from => "WebsiteRole", :as => Fixnum, :to_xml => ONIX::Formatters.two_digit
    xml_accessor :website_description, :from => "WebsiteDescription"
    xml_accessor :website_link,        :from => "WebsiteLink"
  end
end
