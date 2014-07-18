# coding: utf-8

require File.dirname(__FILE__) + '/spec_helper.rb'

describe ONIX::Imprint do

  Given(:doc) { File.read(File.join(File.dirname(__FILE__), "..", "data", "imprint.xml")) }

  describe "should correctly convert to a string" do
    Given(:imp) { ONIX::Imprint.from_xml(doc) }
    Then { imp.to_xml.to_s.start_with? "<Imprint>" }
  end

  describe "should provide read access to first level attributes" do
    Given(:imp) { ONIX::Imprint.from_xml(doc) }
    Then { imp.imprint_name == "Oxford University Press UK" }
  end

  context "should provide write access to first level attributes" do
    Given(:imp) { ONIX::Imprint.new }
    describe :imprint_name= do
      When { imp.imprint_name = "Paulist Press" }
      Then { imp.to_xml.to_s.include? "<ImprintName>Paulist Press</ImprintName>" }
    end
    describe :name_code_type= do
      When { imp.name_code_type = 1 }
      Then { imp.to_xml.to_s.include? "<NameCodeType>01</NameCodeType>" }
    end
  end

end
