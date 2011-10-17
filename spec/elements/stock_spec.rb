# coding: utf-8

require 'spec_helper.rb'

describe ONIX::Stock do

  before(:each) do
    load_doc_and_root("stock.xml")
  end

  it "should correctly convert to a string" do
    s = ONIX::Stock.from_xml(@root.to_s)
    s.to_xml.to_s[0,7].should eql("<Stock>")
  end

  it "should provide read access to first level attributes" do
    s = ONIX::Stock.from_xml(@root.to_s)

    # note that these fields *should* be numeric according to the ONIX spec,
    # however heaps of ONIX files in the wild have strings there.
    s.on_hand.should eql("2862")
    s.on_order.should eql("0")
  end

  it "should provide write access to first level attributes" do
    s = ONIX::Stock.new

    s.on_hand = "123"
    s.to_xml.to_s.include?("<OnHand>123</OnHand>").should be_true

    s.on_order = "011"
    s.to_xml.to_s.include?("<OnOrder>011</OnOrder>").should be_true

    s.on_order = 11
    s.to_xml.to_s.include?("<OnOrder>11</OnOrder>").should be_true
  end

end

