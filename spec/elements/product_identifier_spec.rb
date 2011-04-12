# coding: utf-8

require 'spec_helper.rb'

describe ONIX::ProductIdentifier do

  before(:each) do
    load_doc_and_root("product_identifier.xml")
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

