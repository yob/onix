# coding: utf-8

require 'spec_helper.rb'

describe "ONIX::SalesRestriction" do

  before(:each) do
    load_doc_and_root("sales_restriction.xml")
  end

  it "should correctly convert to a string" do
    sr = ONIX::SalesRestriction.from_xml(@root.to_s)
    sr.to_xml.to_s[0,18].should eql("<SalesRestriction>")
  end

  it "should provide read access to first level attributes" do
    sr = ONIX::SalesRestriction.from_xml(@root.to_s)

    sr.sales_restriction_type.should eql(0)
  end

  it "should provide write access to first level attributes" do
    sr = ONIX::SalesRestriction.new

    sr.sales_restriction_type = 1
    sr.to_xml.to_s.include?("<SalesRestrictionType>01</SalesRestrictionType>").should be_true
  end

end
