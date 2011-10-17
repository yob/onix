# coding: utf-8

require 'spec_helper.rb'

describe ONIX::OtherText do

  before(:each) do
    load_doc_and_root("other_text.xml")
  end

  it "should correctly convert to a string" do
    ot = ONIX::OtherText.from_xml(@root.to_s)
    ot.to_xml.to_s[0,11].should eql("<OtherText>")
  end

  it "should provide read access to first level attributes" do
    ot = ONIX::OtherText.from_xml(@root.to_s)

    ot.text_type_code.should eql(2)
    ot.text[0,7].should eql("A woman")
  end

  it "should provide write access to first level attributes" do
    ot = ONIX::OtherText.new

    ot.text_type_code = 2
    ot.to_xml.to_s.include?("<TextTypeCode>02</TextTypeCode>").should be_true

    ot.text = "James Healy"
    ot.to_xml.to_s.include?("<Text>James Healy</Text>").should be_true

  end

end

