# coding: utf-8

require 'spec_helper'

describe ONIX2::Imprint do

  Given(:doc) { load_xml "imprint.xml" }

  describe "should correctly convert to a string" do
    Given(:imp) { ONIX2::Imprint.from_xml(doc) }
    Then { imp.to_xml.to_s.start_with? "<Imprint>" }
  end

  describe "should provide read access to first level attributes" do
    Given(:imp) { ONIX2::Imprint.from_xml(doc) }
    Then { imp.imprint_name == "Oxford University Press UK" }
  end

  context "should provide write access to first level attributes" do
    Given(:imp) { ONIX2::Imprint.new }
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
