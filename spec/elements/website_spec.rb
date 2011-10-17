# coding: utf-8

require 'spec_helper.rb'

describe ONIX::Website do

  before(:each) do
    load_doc_and_root("website.xml")
  end

  it "should correctly convert to a string" do
    web = ONIX::Website.from_xml(@root.to_s)
    web.to_xml.to_s[0,9].should eql("<Website>")
  end

  it "should provide read access to first level attributes" do
    web = ONIX::Website.from_xml(@root.to_s)

    web.website_role.should eql(1)
    web.website_link.should eql("http://www.rainbowbooks.com.au")
  end

  it "should provide write access to first level attributes" do
    web = ONIX::Website.new

    web.website_role = 2
    web.to_xml.to_s.include?("<WebsiteRole>02</WebsiteRole>").should be_true

    web.website_link = "http://www.yob.id.au"
    web.to_xml.to_s.include?("<WebsiteLink>http://www.yob.id.au</WebsiteLink>").should be_true

  end

end


