# coding: utf-8

require File.dirname(__FILE__) + '/spec_helper.rb'

describe ONIX::ProductIdentifier do

  Given(:doc) { File.read(File.join(File.dirname(__FILE__), "..", "data", "product_identifier.xml")) }

  describe "should correctly convert to a string" do
    Given(:id) { ONIX::ProductIdentifier.from_xml(doc) }
    Then { id.to_xml.to_s.start_with? "<ProductIdentifier>" }
  end

  describe "should provide read access to first level attributes" do
    Given(:id) { ONIX::ProductIdentifier.from_xml(doc) }

    Then { id.product_id_type == 2 }
    Then { id.id_value == "0858198363" }
  end

  context "should provide write access to first level attributes" do
    Given(:id) { ONIX::ProductIdentifier.new }

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
