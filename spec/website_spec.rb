# coding: utf-8

require File.dirname(__FILE__) + '/spec_helper.rb'

describe ONIX::Website do

  Given(:doc) { File.read(File.join(File.dirname(__FILE__), "..", "data", "website.xml")) }

  describe "should correctly convert to a string" do
    Given(:web){ ONIX::Website.from_xml(doc) }
    Then{ web.to_xml.to_s.start_with? "<Website>" }
  end

  describe "should provide read access to first level attributes" do
    Given(:web) { ONIX::Website.from_xml(doc) }

    Then { web.website_role == 1 }
    Then { web.website_link == "http://www.rainbowbooks.com.au" }
  end

  context "should provide write access to first level attributes" do
    Given(:web) { ONIX::Website.new }
    describe :website_role= do
      When { web.website_role = 2 }
      Then { web.to_xml.to_s.include? "<WebsiteRole>02</WebsiteRole>" }
    end
    describe :website_link= do
      When { web.website_link = "http://www.yob.id.au" }
      Then { web.to_xml.to_s.include? "<WebsiteLink>http://www.yob.id.au</WebsiteLink>" }
    end
  end

end
