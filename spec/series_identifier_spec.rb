# coding: utf-8

require 'spec_helper'

describe ONIX2::SeriesIdentifier do

  Given(:doc) { load_xml "series_identifier.xml" }

  describe "should correctly convert to a string" do
    Given(:series) { ONIX2::SeriesIdentifier.from_xml(doc) }
    Then { series.to_xml.to_s.start_with? "<SeriesIdentifier>" }
  end

  describe "should provide read access to first level attributes" do
    Given(:series) { ONIX2::SeriesIdentifier.from_xml(doc) }

    Then { series.series_id_type == 1 }
    Then { series.id_value == "10001" }
  end

  context "should provide write access to first level attributes" do
    Given(:series) { ONIX2::SeriesIdentifier.new }
    describe :series_id_type= do
      When { series.series_id_type = 9 }
      Then { series.to_xml.to_s.include? "<SeriesIDType>09</SeriesIDType>" }
    end
    describe :id_value= do
      When { series.id_value = 999 }
      Then { series.to_xml.to_s.include? "<IDValue>999</IDValue>" }
    end
  end

end
