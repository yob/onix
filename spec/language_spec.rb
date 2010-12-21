# coding: utf-8

require File.dirname(__FILE__) + '/spec_helper.rb'

describe ONIX::Language do

  before(:each) do
    data_path = File.join(File.dirname(__FILE__),"..","data")
    file1    = File.join(data_path, "language.xml")
    @doc = Nokogiri::XML::Document.parse(File.read(file1))
    @root = @doc.root
  end

  it "should correctly convert to a string" do
    lan = ONIX::Language.from_xml(@root.to_s)
    lan.to_xml.to_s[0,10].should eql("<Language>")
  end

  it "should provide read access to first level attributes" do
    lan = ONIX::Language.from_xml(@root.to_s)

    lan.language_role.should eql(1)
    lan.language_code.should eql("eng")
    lan.country_code.should eql("US")
  end

  it "should provide write access to first level attributes" do
    lan = ONIX::Language.new

    lan.language_role = 2
    lan.to_xml.to_s.include?("<LanguageRole>02</LanguageRole>").should be_true

    lan.language_code = "aar"
    lan.to_xml.to_s.include?("<LanguageCode>aar</LanguageCode>").should be_true

    lan.country_code = "AD"
    lan.to_xml.to_s.include?("<CountryCode>AD</CountryCode>").should be_true
  end

end
