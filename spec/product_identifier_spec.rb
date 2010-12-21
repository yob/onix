# coding: utf-8

require File.dirname(__FILE__) + '/spec_helper.rb'

describe ONIX::ProductIdentifier do

  before(:each) do
    data_path = File.join(File.dirname(__FILE__),"..","data")
    file1    = File.join(data_path, "product_identifier.xml")
    @doc     = Nokogiri::XML::Document.parse(File.read(file1))
    @root = @doc.root
  end

  it "should correctly convert to a string" do
    id = ONIX::ProductIdentifier.from_xml(@root.to_s)
    id.to_xml.to_s[0,19].should eql("<ProductIdentifier>")
  end

  it "should provide read access to first level attributes" do
    id = ONIX::ProductIdentifier.from_xml(@root.to_s)

    id.product_id_type.should eql(2)
    id.id_value.should eql("0858198363")
  end

  it "should provide write access to first level attributes" do
    id = ONIX::ProductIdentifier.new

    id.product_id_type = 2
    id.to_xml.to_s.include?("<ProductIDType>02</ProductIDType>").should be_true

    id.id_value = "James"
    id.to_xml.to_s.include?("<IDValue>James</IDValue>").should be_true

  end

end

