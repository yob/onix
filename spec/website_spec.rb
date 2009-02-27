# coding: utf-8

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')

require 'onix'

context "ONIX::Website" do

  before(:each) do
    data_path = File.join(File.dirname(__FILE__),"..","data")
    file1    = File.join(data_path, "website.xml")
    @doc = LibXML::XML::Document.file(file1)
    @root = @doc.root
  end

  specify "should correctly convert to a string" do
    web = ONIX::Website.from_xml(@root.to_s)
    web.to_xml.to_s[0,9].should eql("<Website>")
  end

  specify "should provide read access to first level attibutes" do
    web = ONIX::Website.from_xml(@root.to_s)

    web.website_role.should eql(1)
    web.website_link.should eql("http://www.rainbowbooks.com.au")
  end

  specify "should provide write access to first level attibutes" do
    web = ONIX::Website.new

    web.website_role = 2
    web.to_xml.to_s.include?("<WebsiteRole>02</WebsiteRole>").should be_true

    web.website_link = "http://www.yob.id.au"
    web.to_xml.to_s.include?("<WebsiteLink>http://www.yob.id.au</WebsiteLink>").should be_true

  end

end


