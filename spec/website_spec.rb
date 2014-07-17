# coding: utf-8

require File.dirname(__FILE__) + '/spec_helper.rb'

describe ONIX::Website do

  Given{
    data_path = File.join(File.dirname(__FILE__),"..","data")
    file1    = File.join(data_path, "website.xml")
    @doc     = Nokogiri::XML::Document.parse(File.read(file1))
    @root = @doc.root
  }

  context "should correctly convert to a string" do
    Given(:web){ ONIX::Website.from_xml(@root.to_s) }
    Then{ web.to_xml.to_s[0,9] == "<Website>" }
  end

  context "should provide read access to first level attributes" do
    Given(:web){ ONIX::Website.from_xml(@root.to_s) }

    Then{ web.website_role == 1 }
    And{ web.website_link == "http://www.rainbowbooks.com.au" }
  end

  context "should provide write access to first level attributes" do
    Given(:web){ ONIX::Website.new }

    When{
      web.website_role = 2
      web.website_link = "http://www.yob.id.au"
    }
    Then{ web.to_xml.to_s.include?("<WebsiteRole>02</WebsiteRole>") == true }
    And{ web.to_xml.to_s.include?("<WebsiteLink>http://www.yob.id.au</WebsiteLink>") == true }
  end

end


