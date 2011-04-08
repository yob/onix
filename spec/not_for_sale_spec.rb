# coding: utf-8

require File.dirname(__FILE__) + '/spec_helper.rb'

describe ONIX::NotForSale do

  before(:each) do
    load_doc_and_root("sales_rights.xml")
    @nfs = @root.at_css("NotForSale")
  end


  it "should correctly convert to a string" do
    rep = ONIX::NotForSale.from_xml(@nfs.to_s)
    rep.should produce_the_tag("<NotForSale>")
  end


  it "should provide read access to first level attributes" do
    p = ONIX::Product.from_xml(@root.to_s)
    p.not_for_sales[0].rights_countries.should eql(["UK"])
  end


  it "should provide write access to first level attributes" do
    nfs = ONIX::NotForSale.new
    nfs.rights_countries = ["UK", "US", "IR"]
    nfs.should include_the_xml("<RightsCountry>UK US IR</RightsCountry>")
  end

end
