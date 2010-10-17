# coding: utf-8

require File.dirname(__FILE__) + '/spec_helper.rb'

context "ONIX::SeriesIdentifier" do

  before(:each) do
    data_path = File.join(File.dirname(__FILE__),"..","data")
    file1    = File.join(data_path, "series_identifier.xml")
    @doc = Nokogiri::XML::Document.parse(File.read(file1))
    @root = @doc.root
  end

  specify "should correctly convert to a string" do
    series = ONIX::SeriesIdentifier.from_xml(@root.to_s)
    series.to_xml.to_s[0,18].should eql("<SeriesIdentifier>")
  end

  specify "should provide read access to first level attributes" do
    series = ONIX::SeriesIdentifier.from_xml(@root.to_s)

    series.series_id_type.should eql(1)
    series.id_value.should eql("10001")
  end

  specify "should provide write access to first level attributes" do
    series = ONIX::SeriesIdentifier.new

    series.series_id_type = 9
    series.to_xml.to_s.include?("<SeriesIDType>09</SeriesIDType>").should be_true

    series.id_value = 999
    series.to_xml.to_s.include?("<IDValue>999</IDValue>").should be_true
  end

end
