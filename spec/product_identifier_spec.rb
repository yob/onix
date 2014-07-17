# coding: utf-8

require File.dirname(__FILE__) + '/spec_helper.rb'

describe ONIX::ProductIdentifier do

  Given{
    data_path = File.join(File.dirname(__FILE__),"..","data")
    file1    = File.join(data_path, "product_identifier.xml")
    @doc     = Nokogiri::XML::Document.parse(File.read(file1))
    @root = @doc.root
  }

  context "should correctly convert to a string" do
    Given(:id){ ONIX::ProductIdentifier.from_xml(@root.to_s) }
    Then{ id.to_xml.to_s[0,19] == "<ProductIdentifier>" }
  end

  context "should provide read access to first level attributes" do
    Given(:id){ ONIX::ProductIdentifier.from_xml(@root.to_s) }

    Then{ id.product_id_type == 2 }
    And{ id.id_value == "0858198363" }
  end

  context "should provide write access to first level attributes" do
    Given(:id){ ONIX::ProductIdentifier.new }

    When{ id.product_id_type = 2 }
    When{ id.id_value = "James" }

    Then{ id.to_xml.to_s.include?("<ProductIDType>02</ProductIDType>") == true }
    And{ id.to_xml.to_s.include?("<IDValue>James</IDValue>") == true }

  end

end

