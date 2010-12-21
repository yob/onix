# coding: utf-8

require File.dirname(__FILE__) + '/spec_helper.rb'

describe ONIX::Series do

  before(:each) do
    data_path = File.join(File.dirname(__FILE__),"..","data")
    file1    = File.join(data_path, "series.xml")
    @doc = Nokogiri::XML::Document.parse(File.read(file1))
    @root = @doc.root
  end

  it "should correctly convert to a string" do
    series = ONIX::Series.from_xml(@root.to_s)
    series.to_xml.to_s[0,8].should eql("<Series>")
  end

  it "should provide read access to first level attributes" do
    series = ONIX::Series.from_xml(@root.to_s)

    series.title_of_series.should eql("Citizens and Their Governments")
  end

  it "should provide write access to first level attributes" do
    series = ONIX::Series.new

    series.title_of_series = "Cool Science Careers"
    series.to_xml.to_s.include?("<TitleOfSeries>Cool Science Careers</TitleOfSeries>").should be_true
  end

end
