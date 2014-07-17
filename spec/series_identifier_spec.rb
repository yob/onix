# coding: utf-8

require File.dirname(__FILE__) + '/spec_helper.rb'

describe ONIX::SeriesIdentifier do

  Given{
    data_path = File.join(File.dirname(__FILE__),"..","data")
    file1    = File.join(data_path, "series_identifier.xml")
    @doc = Nokogiri::XML::Document.parse(File.read(file1))
    @root = @doc.root
  }

  context "should correctly convert to a string" do
    Given(:series){ ONIX::SeriesIdentifier.from_xml(@root.to_s) }
    Then{ series.to_xml.to_s[0,18] == "<SeriesIdentifier>" }
  end

  context "should provide read access to first level attributes" do
    Given(:series){ ONIX::SeriesIdentifier.from_xml(@root.to_s) }

    Then{ series.series_id_type == 1 }
    And{ series.id_value == "10001" }
  end

  context "should provide write access to first level attributes" do
    Given(:series){ ONIX::SeriesIdentifier.new }

    When{ series.series_id_type = 9 }
    When{ series.id_value = 999 }

    Then{ series.to_xml.to_s.include?("<SeriesIDType>09</SeriesIDType>") == true }
    And{ series.to_xml.to_s.include?("<IDValue>999</IDValue>") == true }
  end

end
