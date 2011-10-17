# coding: utf-8

class ONIX::Website < ONIX::Element
  xml_name "Website"
  onix_code_from_list :website_role, "WebsiteRole", :list => 73
  xml_accessor :website_description, :from => "WebsiteDescription"
  xml_accessor :website_link, :from => "WebsiteLink"
end
