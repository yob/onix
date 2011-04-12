# coding: utf-8

require 'spec_helper.rb'

describe ONIX::SenderIdentifier do

  before(:each) do
    load_doc_and_root("sender_identifier.xml")
  end

  it "should correctly convert to a string" do
    id = ONIX::SenderIdentifier.from_xml(@root.to_s)
    id.to_xml.to_s[0,18].should eql("<SenderIdentifier>")
  end

  it "should provide read access to first level attributes" do
    id = ONIX::SenderIdentifier.from_xml(@root.to_s)

    id.sender_id_type.should eql(1)
    id.id_value.should eql("123456")
  end

  it "should provide write access to first level attributes" do
    id = ONIX::SenderIdentifier.new

    id.sender_id_type = 1
    id.to_xml.to_s.include?("<SenderIDType>01</SenderIDType>").should be_true

    id.id_value = "54321"
    id.to_xml.to_s.include?("<IDValue>54321</IDValue>").should be_true

  end

end

