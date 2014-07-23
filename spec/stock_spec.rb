# coding: utf-8

require 'spec_helper'

describe ONIX::Stock do

  Given(:doc) { load_xml "stock.xml" }

  describe "should correctly convert to a string" do
    Given(:s) { ONIX::Stock.from_xml(doc) }
    Then { s.to_xml.to_s.start_with? "<Stock>" }
  end

  describe "should provide read access to first level attributes" do
    Given(:s) { ONIX::Stock.from_xml(doc) }

    # note that these fields *should* be numeric according to the ONIX spec,
    # however heaps of ONIX files in the wild have strings there.
    Then { s.on_hand == "2862" }
    Then { s.on_order == "0" }
  end

  context "should provide write access to first level attributes" do
    Given(:s) { ONIX::Stock.new }
    describe :on_hand= do
      When { s.on_hand = "123" }
      Then { s.to_xml.to_s.include? "<OnHand>123</OnHand>" }
    end
    describe :on_order= do
      When { s.on_order = "011" }
      Then { s.to_xml.to_s.include? "<OnOrder>011</OnOrder>" }
    end
    describe :on_order= do
      When { s.on_order = 11 }
      Then { s.to_xml.to_s.include? "<OnOrder>11</OnOrder>" }
    end
  end

end
