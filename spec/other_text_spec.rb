# coding: utf-8

require File.dirname(__FILE__) + '/spec_helper.rb'

describe ONIX::OtherText do

  Given(:doc) { File.read(File.join(File.dirname(__FILE__), "..", "data", "other_text.xml")) }

  describe "should correctly convert to a string" do
    Given(:ot) { ONIX::OtherText.from_xml(doc) }
    Then { ot.to_xml.to_s.start_with? "<OtherText>" }
  end

  describe "should provide read access to first level attributes" do
    Given(:ot) { ONIX::OtherText.from_xml(doc) }

    Then { ot.text_type_code == 2 }
    Then { ot.text.start_with? "A woman" }
  end

  context "should provide write access to first level attributes" do
    Given(:ot) { ONIX::OtherText.new }
    describe :text_type_code= do
      When { ot.text_type_code = 2 }
      Then { ot.to_xml.to_s.include? "<TextTypeCode>02</TextTypeCode>" }
    end
    describe :text= do
      When { ot.text = "James Healy" }
      Then { ot.to_xml.to_s.include? "<Text>James Healy</Text>" }
    end
  end

end
