# coding: utf-8

require File.dirname(__FILE__) + '/spec_helper.rb'

describe ONIX::Series do

  Given{
    data_path = File.join(File.dirname(__FILE__),"..","data")
    file1    = File.join(data_path, "series.xml")
    @doc = Nokogiri::XML::Document.parse(File.read(file1))
    @root = @doc.root
  }

  context "should correctly convert to a string" do
    Given(:series){ ONIX::Series.from_xml(@root.to_s) }

    Then{ series.to_xml.to_s[0,8] == "<Series>" }
  end

  context "should provide read access to first level attributes" do
    Given(:series){ ONIX::Series.from_xml(@root.to_s) }

    Then{ series.title_of_series == "Citizens and Their Governments" }
  end

  context "should provide write access to first level attributes" do
    Given(:series){ ONIX::Series.new }

    When{ series.title_of_series = "Cool Science Careers" }
    Then{ series.to_xml.to_s.include?("<TitleOfSeries>Cool Science Careers</TitleOfSeries>") == true }
  end

end
