module ONIX
  class Website
    include XML::Mapping

    numeric_node :website_role,        "WebsiteRole", :optional => true
    text_node    :website_description, "WebsiteDescription", :optional => true
    text_node    :website_link,        "WebsiteLink"
  end
end
