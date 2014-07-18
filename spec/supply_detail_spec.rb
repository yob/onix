# coding: utf-8

require File.dirname(__FILE__) + '/spec_helper.rb'

describe ONIX::SupplyDetail do

  Given(:doc) { File.read(File.join(File.dirname(__FILE__), "..", "data", "supply_detail.xml")) }

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

end
