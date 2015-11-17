# coding: utf-8

require 'spec_helper'

describe ONIX2::Measure do

  Given(:doc) { load_xml "measure.xml" }

  describe "should correctly convert to a string" do
    Given(:m) { ONIX2::Measure.from_xml(doc) }
    Then { m.to_xml.to_s.start_with? "<Measure>" }
  end

  describe "should provide read access to first level attributes" do
    Given(:m) { ONIX2::Measure.from_xml(doc) }

    Then { m.measure_type_code == 1 }
    Then { m.measurement == 210 }
    Then { m.measure_unit_code == "mm" }
  end

  context "should provide write access to first level attributes" do
    Given(:m) { ONIX2::Measure.new }
    describe :measure_type_code= do
      When { m.measure_type_code = 1 }
      Then { m.to_xml.to_s.include? "<MeasureTypeCode>01</MeasureTypeCode>" }
    end
    describe :measurement= do
      When { m.measurement = 300 }
      Then { m.to_xml.to_s.include? "<Measurement>300</Measurement>" }
    end
    describe :measure_unit_code= do
      When { m.measure_unit_code = "mm" }
      Then { m.to_xml.to_s.include? "<MeasureUnitCode>mm</MeasureUnitCode>" }
    end
  end

end
