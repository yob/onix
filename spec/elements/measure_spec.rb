# coding: utf-8

require 'spec_helper.rb'

describe ONIX::Measure do

  before(:each) do
    load_doc_and_root("measure.xml")
  end

  it "should correctly convert to a string" do
    m = ONIX::Measure.from_xml(@root.to_s)
    m.to_xml.to_s[0,9].should eql("<Measure>")
  end

  it "should provide read access to first level attributes" do
    m = ONIX::Measure.from_xml(@root.to_s)

    m.measure_type_code.should eql(1)
    m.measurement.should eql(210)
    m.measure_unit_code.should eql("mm")
  end

  it "should provide write access to first level attributes" do
    m = ONIX::Measure.new

    m.measure_type_code = 1
    m.to_xml.to_s.include?("<MeasureTypeCode>01</MeasureTypeCode>").should be_true

    m.measurement = 300
    m.to_xml.to_s.include?("<Measurement>300</Measurement>").should be_true

    m.measure_unit_code = "mm"
    m.to_xml.to_s.include?("<MeasureUnitCode>mm</MeasureUnitCode>").should be_true
  end

end

