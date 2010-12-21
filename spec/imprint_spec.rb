# coding: utf-8

require File.dirname(__FILE__) + '/spec_helper.rb'

describe ONIX::Imprint do

  before(:each) do
    data_path = File.join(File.dirname(__FILE__),"..","data")
    file1     = File.join(data_path, "imprint.xml")
    @doc      = Nokogiri::XML::Document.parse(File.read(file1))
    @root     = @doc.root
  end

  it "should correctly convert to a string" do
    imp = ONIX::Imprint.from_xml(@root.to_s)
    imp.to_xml.to_s[0,9].should eql("<Imprint>")
  end

  it "should provide read access to first level attributes" do
    imp = ONIX::Imprint.from_xml(@root.to_s)

    imp.imprint_name.should eql("Oxford University Press UK")
  end

  it "should provide write access to first level attributes" do
    imp = ONIX::Imprint.new

    imp.imprint_name = "Paulist Press"
    imp.to_xml.to_s.include?("<ImprintName>Paulist Press</ImprintName>").should be_true

    imp.name_code_type = 1
    imp.to_xml.to_s.include?("<NameCodeType>01</NameCodeType>").should be_true

  end

end

