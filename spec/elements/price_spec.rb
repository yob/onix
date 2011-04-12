# coding: utf-8

require 'spec_helper.rb'

describe ONIX::Price do

  before(:each) do
    load_doc_and_root("price.xml")
  end

  it "should correctly convert to a string" do
    p = ONIX::Price.from_xml(@root.to_s)
    p.to_xml.to_s[0,7].should eql("<Price>")
  end

  it "should provide read access to first level attributes" do
    p = ONIX::Price.from_xml(@root.to_s)

    p.price_type_code.should eql(2)
    p.price_amount.should eql(BigDecimal.new("7.5"))
  end

  it "should provide write access to first level attributes" do
    p = ONIX::Price.new

    p.price_type_code = 1
    p.to_xml.to_s.include?("<PriceTypeCode>01</PriceTypeCode>").should be_true

    p.price_amount = BigDecimal.new("7.5")
    p.to_xml.to_s.include?("<PriceAmount>7.5</PriceAmount>").should be_true

  end

end

