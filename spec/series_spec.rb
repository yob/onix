# coding: utf-8

require 'spec_helper'

describe ONIX::Series do

  Given(:doc) { load_xml "series.xml" }

  context "should correctly convert to a string" do
    Given(:series) { ONIX::Series.from_xml(doc) }

    Then{ series.to_xml.to_s.start_with? "<Series>" }
  end

  context "should provide read access to first level attributes" do
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

end
