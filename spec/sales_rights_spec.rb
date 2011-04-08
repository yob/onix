# coding: utf-8

require File.dirname(__FILE__) + '/spec_helper.rb'

describe ONIX::SalesRights do

  before(:each) do
    load_doc_and_root("sales_rights.xml")
    @first_right = @root.at_css("SalesRights")
  end


  it "should correctly convert to a string" do
    rep = ONIX::SalesRights.from_xml(@first_right.to_s)
    rep.should produce_the_tag("<SalesRights")
  end


  it "should provide read access to first level attributes" do
    p = ONIX::Product.from_xml(@root.to_s)
    p.sales_rights[0].sales_rights_type.should eql(1)
    p.sales_rights[1].rights_countries.should eql(["AU", "NZ"])
  end


  it "should provide write access to first level attributes" do
    sr = ONIX::SalesRights.new
    sr.sales_rights_type = 2
    sr.should include_the_xml("<SalesRightsType>02</SalesRightsType>")
    sr.rights_territories = ["WORLD"]
    sr.should include_the_xml("<RightsTerritory>WORLD</RightsTerritory>")
  end

  it "should provide an array for deprecated rights regions" do
    p = ONIX::Product.from_xml(@root.to_s)
    p.sales_rights[2].rights_region.should eql(["001", "002", "003", "004"])
  end

end
