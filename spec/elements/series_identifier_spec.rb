# coding: utf-8

require 'spec_helper.rb'

describe ONIX::SeriesIdentifier do

  before(:each) do
    load_doc_and_root("series_identifier.xml")
  end

  it "should correctly convert to a string" do
    series = ONIX::SeriesIdentifier.from_xml(@root.to_s)
    series.to_xml.to_s[0,18].should eql("<SeriesIdentifier>")
  end

  it "should provide read access to first level attributes" do
    series = ONIX::SeriesIdentifier.from_xml(@root.to_s)

    series.series_id_type.should eql(1)
    series.id_value.should eql("10001")
  end

  it "should provide write access to first level attributes" do
    series = ONIX::SeriesIdentifier.new

    series.series_id_type = 9
    series.to_xml.to_s.include?("<SeriesIDType>09</SeriesIDType>").should be_true

    series.id_value = 999
    series.to_xml.to_s.include?("<IDValue>999</IDValue>").should be_true
  end

end
