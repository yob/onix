# coding: utf-8

require File.dirname(__FILE__) + '/spec_helper.rb'

describe ONIX::SenderIdentifier do

  Given{
    data_path = File.join(File.dirname(__FILE__),"..","data")
    file1    = File.join(data_path, "sender_identifier.xml")
    @doc     = Nokogiri::XML::Document.parse(File.read(file1))
    @root = @doc.root
  }

  context "should correctly convert to a string" do
    Given(:id){ONIX::SenderIdentifier.from_xml(@root.to_s)}
    Then { id.to_xml.to_s[0,18] == "<SenderIdentifier>" }
  end

  context "should provide read access to first level attributes" do
    Given(:id){ONIX::SenderIdentifier.from_xml(@root.to_s)}
    Then{ id.sender_id_type == 1 }
    And{ id.id_value == "123456" }
  end

  context "should provide write access to first level attributes" do
    Given(:id){ ONIX::SenderIdentifier.new }
    When{ id.sender_id_type = 1 }
    When{ id.id_value = "54321" }
    Then{ id.to_xml.to_s.include?("<SenderIDType>01</SenderIDType>") == true }
    And{ id.to_xml.to_s.include?("<IDValue>54321</IDValue>") == true }
  end

end

