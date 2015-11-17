# coding: utf-8

require 'spec_helper'

describe ONIX2::ProductIdentifier do

  Given(:doc) { load_xml "product_identifier.xml" }

  describe "should correctly convert to a string" do
    Given(:id) { ONIX2::ProductIdentifier.from_xml(doc) }
    Then { id.to_xml.to_s.start_with? "<ProductIdentifier>" }
  end

  describe "should provide read access to first level attributes" do
    Given(:id) { ONIX2::ProductIdentifier.from_xml(doc) }

    Then { id.product_id_type == 2 }
    Then { id.id_value == "0858198363" }
  end

  context "should provide write access to first level attributes" do
    Given(:id) { ONIX2::ProductIdentifier.new }

    describe :product_id_type= do
      When { id.product_id_type = 2 }
      Then { id.to_xml.to_s.include? "<ProductIDType>02</ProductIDType>" }
    end
    describe :id_value= do
      When { id.id_value = "James" }
      Then { id.to_xml.to_s.include? "<IDValue>James</IDValue>" }
    end
  end

end
