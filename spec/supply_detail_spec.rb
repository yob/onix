# coding: utf-8

require File.dirname(__FILE__) + '/spec_helper.rb'

describe ONIX::SupplyDetail do

  before(:each) do
    data_path = File.join(File.dirname(__FILE__),"..","data")
    file1    = File.join(data_path, "supply_detail.xml")
    @doc     = Nokogiri::XML::Document.parse(File.read(file1))
    @root = @doc.root
  end

  it "should correctly convert to a string" do
    sd = ONIX::SupplyDetail.from_xml(@root.to_s)
    sd.to_xml.to_s[0,14].should eql("<SupplyDetail>")
  end

  it "should provide read access to first level attributes" do
    sd = ONIX::SupplyDetail.from_xml(@root.to_s)

    sd.supplier_name.should eql("Rainbow Book Agencies")
    sd.product_availability.should eql(21)
    sd.stock.should be_a_kind_of(Array)
    sd.stock.size.should eql(1)
    sd.pack_quantity.should eql(16)
    sd.prices.should be_a_kind_of(Array)
    sd.prices.size.should eql(1)
  end

  it "should provide write access to first level attributes" do
    sd = ONIX::SupplyDetail.new

    sd.supplier_name = "RBA"
    sd.to_xml.to_s.include?("<SupplierName>RBA</SupplierName>").should be_true

    sd.supplier_role = 1
    sd.to_xml.to_s.include?("<SupplierRole>01</SupplierRole>").should be_true

    sd.availability_status_code = 2
    sd.to_xml.to_s.include?("<AvailabilityStatusCode>02</AvailabilityStatusCode>").should be_true

    sd.product_availability = 3
    sd.to_xml.to_s.include?("<ProductAvailability>03</ProductAvailability>").should be_true

    sd.pack_quantity = 12
    sd.to_xml.to_s.include?("<PackQuantity>12</PackQuantity>").should be_true
  end

end

