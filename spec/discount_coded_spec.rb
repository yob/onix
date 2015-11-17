# coding: utf-8

require 'spec_helper'

describe ONIX2::DiscountCoded do

  Given(:doc) { load_xml "discount_coded.xml" }

  describe "should correctly convert to a string" do
    Given(:dc) { ONIX2::DiscountCoded.from_xml(doc) }
    Then { dc.to_xml.to_s.start_with? "<DiscountCoded>" }
  end

  describe "should provide read access to first level attributes" do
    Given(:dc) { ONIX2::DiscountCoded.from_xml(doc) }

    Then { dc.discount_code_type == 2 }
    Then { dc.discount_code_type_name == "IngramDC" }
    Then { dc.discount_code == "AHACP033" }
  end

  context "should provide write access to first level attributes" do
    Given(:dc) { ONIX2::DiscountCoded.new }
    describe :discount_code_type= do
      When { dc.discount_code_type = 1 }
      Then { dc.to_xml.to_s.include? "<DiscountCodeType>01</DiscountCodeType>" }
    end
    describe :discount_code= do
      When { dc.discount_code = "AHGFCP056" }
      Then { dc.to_xml.to_s.include? "<DiscountCode>AHGFCP056</DiscountCode>" }
    end
  end

end
