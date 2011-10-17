# coding: utf-8

require 'spec_helper.rb'

describe ONIX::AudienceRange do

  before(:each) do
    load_doc_and_root("audience_range.xml")
  end

  it "should correctly convert to a string" do
    aud = ONIX::AudienceRange.from_xml(@root.to_s)
    aud.to_xml.to_s[0,15].should eql("<AudienceRange>")
  end

  it "should provide read access to first level attributes" do
    aud = ONIX::AudienceRange.from_xml(@root.to_s)

    aud.audience_range_qualifier.should eql(11)
    aud.audience_range_precisions.size.should eql(2)
    aud.audience_range_precisions[0].should eql(3)
    aud.audience_range_precisions[1].should eql(4)
    aud.audience_range_values.size.should eql(2)
    aud.audience_range_values[0].should eql(3)
    aud.audience_range_values[1].should eql(5)
  end

  it "should provide write access to first level attributes" do
    aud = ONIX::AudienceRange.new

    aud.audience_range_qualifier = 12
    aud.to_xml.to_s.include?("<AudienceRangeQualifier>12</AudienceRangeQualifier>").should be_true

    aud.audience_range_precisions = [888]
    aud.to_xml.to_s.include?("<AudienceRangePrecision>888</AudienceRangePrecision>").should be_true

    aud.audience_range_values = [999]
    aud.to_xml.to_s.include?("<AudienceRangeValue>999</AudienceRangeValue>").should be_true
  end

end
