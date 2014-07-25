# coding: utf-8

require 'spec_helper'

describe ONIX::Series do

  Given(:doc) { load_xml "series.xml" }

  describe "should correctly convert to a string" do
    Given(:series) { ONIX::Series.from_xml(doc) }

    Then{ series.to_xml.to_s.start_with? "<Series>" }
  end

  describe "should provide read access to first level attributes" do
    Given(:series) { ONIX::Series.from_xml(doc) }

    Then{  series.title_of_series == "Citizens and Their Governments" }
  end

  context "should provide write access to first level attributes" do
    Given(:series) { ONIX::Series.new }
    describe :title_of_series= do
      When { series.title_of_series = "Cool Science Careers" }
      Then { series.to_xml.to_s.include? "<TitleOfSeries>Cool Science Careers</TitleOfSeries>" }
    end
  end

  describe "should provide read access to series IDs" do
    Given(:series) { ONIX::Series.from_xml(doc) }
    Then { series.series_identifiers.size == 2 }
  end

  context "should provide write access to series IDs" do
    Given(:series_identifier1) { ONIX::SeriesIdentifier.new(series_id_type: 1, id_value: 10001) }
    Given(:series_identifier2) { ONIX::SeriesIdentifier.new(series_id_type: 2, id_value: 20002) }
    Given(:series) { ONIX::Series.new }

    describe :series_identifiers= do
      When { series.series_identifiers = [series_identifier1, series_identifier2] }

      Then { series.to_xml.to_s.include? "<SeriesIDType>01</SeriesIDType>" }
      Then { series.to_xml.to_s.include? "<IDValue>20002</IDValue>" }
    end
  end

end
