# coding: utf-8

require 'spec_helper'

describe ONIX::SupplyDetail do

  Given(:doc) { load_xml "supply_detail.xml" }

  describe "should correctly convert to a string" do
    Given(:sd) { ONIX::SupplyDetail.from_xml(doc) }
    Then { sd.to_xml.to_s.start_with? "<SupplyDetail>" }
  end

  describe "should provide read access to first level attributes" do
    Given(:sd) { ONIX::SupplyDetail.from_xml(doc) }

    Then { sd.supplier_name == "Rainbow Book Agencies" }
    Then { sd.product_availability == 21 }
    Then { sd.stock.is_a? Array }
    Then { sd.stock.size == 1 }
    Then { sd.pack_quantity == 16 }
    Then { sd.prices.is_a? Array }
    Then { sd.prices.size == 1 }
  end

  context "should provide write access to first level attributes" do
    Given(:sd) { ONIX::SupplyDetail.new }
    describe :supplier_name= do
      When { sd.supplier_name = "RBA" }
      Then { sd.to_xml.to_s.include? "<SupplierName>RBA</SupplierName>" }
    end
    describe :supplier_role= do
      When { sd.supplier_role = 1 }
      Then { sd.to_xml.to_s.include? "<SupplierRole>01</SupplierRole>" }
    end
    describe :availability_status_code= do
      When { sd.availability_status_code = 2 }
      Then { sd.to_xml.to_s.include? "<AvailabilityStatusCode>02</AvailabilityStatusCode>" }
    end
    describe :product_availability= do
      When { sd.product_availability = 3 }
      Then { sd.to_xml.to_s.include? "<ProductAvailability>03</ProductAvailability>" }
    end
    describe :pack_quantity= do
      When { sd.pack_quantity = 12 }
      Then { sd.to_xml.to_s.include? "<PackQuantity>12</PackQuantity>" }
    end
  end

  describe "should provide read access to website IDs" do
    Given(:sd) { ONIX::SupplyDetail.from_xml(doc) }
    Then { sd.websites.size == 2 }
  end

  context "should provide write access to website IDs" do
    Given(:website) { ONIX::Website.new(website_role: 1) }
    Given(:sd) { ONIX::SupplyDetail.new }

    describe :series_identifiers= do
      When { sd.websites = [website] }
      Then { sd.to_xml.to_s.include? "<WebsiteRole>01</WebsiteRole>" }
    end
  end

  describe "should provide read access to stock IDs" do
    Given(:sd) { ONIX::SupplyDetail.from_xml(doc) }
    Then { sd.stock.size == 1 }
  end

  context "should provide write access to stock IDs" do
    Given(:stock1) { ONIX::Stock.new(on_hand: 1251) }
    Given(:stock2) { ONIX::Stock.new(on_hand: 52458, on_order: 0) }
    Given(:sd) { ONIX::SupplyDetail.new }

    describe :series_identifiers= do
      When { sd.stock = [stock1, stock2] }
      Then { sd.to_xml.to_s.include? "<OnHand>1251</OnHand>" }
      Then { sd.to_xml.to_s.include? "<OnOrder>0</OnOrder>" }
    end
  end

  describe "should provide read access to price IDs" do
    Given(:sd) { ONIX::SupplyDetail.from_xml(doc) }
    Then { sd.prices.size == 1 }
  end

  context "should provide write access to price IDs" do
    Given(:price) { ONIX::Price.new(price_amount: BigDecimal.new("0.59")) }
    Given(:sd) { ONIX::SupplyDetail.new }

    describe :series_identifiers= do
      When { sd.prices = [price] }
      Then { sd.to_xml.to_s.include? "<PriceAmount>0.59</PriceAmount>" }
    end
  end

end
