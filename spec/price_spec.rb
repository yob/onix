# coding: utf-8

require 'spec_helper'

describe ONIX2::Price do

  Given(:doc) { load_xml "price.xml" }

  describe "should correctly convert to a string" do
    Given(:p) { ONIX2::Price.from_xml(doc) }
    Then { p.to_xml.to_s.start_with? "<Price>" }
  end

  describe "should provide read access to first level attributes" do
    Given(:p) { ONIX2::Price.from_xml(doc) }

    Then { p.price_type_code == 2 }
    Then { p.price_amount == BigDecimal.new("7.5") }
  end

  context "should provide write access to first level attributes" do
    Given(:p) { ONIX2::Price.new }
    describe :price_type_code= do
      When { p.price_type_code = 1 }
      Then { p.to_xml.to_s.include? "<PriceTypeCode>01</PriceTypeCode>" }
    end
    describe :price_amount= do
      When { p.price_amount = BigDecimal.new("7.5") }
      Then { p.to_xml.to_s.include? "<PriceAmount>7.5</PriceAmount>" }
    end
  end

  describe "should provide read access to discount_coded IDs" do
    Given(:p) { ONIX2::Price.from_xml(doc) }
    Then { p.discounts_coded.size == 2 }
  end

  context "should provide write access to discount_coded IDs" do
    Given(:discount_coded1) { ONIX2::DiscountCoded.new(discount_code_type: 1) }
    Given(:discount_coded2) { ONIX2::DiscountCoded.new(discount_code: "code2") }
    Given(:p) { ONIX2::Price.new }

    describe :series_identifiers= do
      When { p.discounts_coded = [discount_coded1, discount_coded2] }

      Then { p.to_xml.to_s.include? "<DiscountCodeType>01</DiscountCodeType>" }
      Then { p.to_xml.to_s.include? "<DiscountCode>code2</DiscountCode>" }
    end
  end

end
