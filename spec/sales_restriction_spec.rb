# coding: utf-8

require 'spec_helper'

describe "ONIX::SalesRestriction" do

  Given(:doc) { load_xml "sales_restriction.xml" }

  describe "should correctly convert to a string" do
    Given(:sr) { ONIX::SalesRestriction.from_xml(doc) }
    Then { sr.to_xml.to_s.start_with? "<SalesRestriction>" }
  end

  describe "should provide read access to first level attributes" do
    Given(:sr) { ONIX::SalesRestriction.from_xml(doc) }
    Then { sr.sales_restriction_type == 0 }
  end

  context "should provide write access to first level attributes" do
    Given(:sr) { ONIX::SalesRestriction.new }
    describe :sales_restriction_type= do
      When { sr.sales_restriction_type = 1 }
      Then { sr.to_xml.to_s.include? "<SalesRestrictionType>01</SalesRestrictionType>" }
    end
  end

end
