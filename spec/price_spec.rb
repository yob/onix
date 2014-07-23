# coding: utf-8

require 'spec_helper'

describe ONIX::Price do

  Given(:doc) { load_xml "price.xml" }

  describe "should correctly convert to a string" do
    Given(:p) { ONIX::Price.from_xml(doc) }
    Then { p.to_xml.to_s.start_with? "<Price>" }
  end

  describe "should provide read access to first level attributes" do
    Given(:p) { ONIX::Price.from_xml(doc) }

    Then { p.price_type_code == 2 }
    Then { p.price_amount == BigDecimal.new("7.5") }
  end

  context "should provide write access to first level attributes" do
    Given(:p) { ONIX::Price.new }
    describe :price_type_code= do
      When { p.price_type_code = 1 }
      Then { p.to_xml.to_s.include?   "<PriceTypeCode>01</PriceTypeCode>" }
    end
    describe :price_amount= do
      When { p.price_amount = BigDecimal.new("7.5") }
      Then { p.to_xml.to_s.include? "<PriceAmount>7.5</PriceAmount>" }
    end
  end

end
