# coding: utf-8

require 'spec_helper'

describe ONIX2::AddresseeIdentifier do

  Given(:doc) { load_xml "addressee.xml" }

  describe "should correctly convert to a string" do
    Given(:id) { ONIX2::AddresseeIdentifier.from_xml(doc) }
    Then { id.to_xml.to_s.start_with? "<AddresseeIdentifier>" }
  end

  describe "should provide read access to first level attributes" do
    Given(:id) { ONIX2::AddresseeIdentifier.from_xml(doc) }

    Then { id.addressee_id_type == 1 }
    Then { id.id_value == "123456" }
  end

  context "should provide write access to first level attributes" do
    Given(:id) { ONIX2::AddresseeIdentifier.new }
    describe :addressee_id_type= do
      When { id.addressee_id_type = 1 }
      Then { id.to_xml.to_s.include? "<AddresseeIDType>01</AddresseeIDType>" }
    end
    describe :id_value= do
      When { id.id_value = "54321" }
      Then { id.to_xml.to_s.include? "<IDValue>54321</IDValue>" }
    end
  end

end
