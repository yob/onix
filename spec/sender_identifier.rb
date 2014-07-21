# coding: utf-8

require 'spec_helper'

describe ONIX::SenderIdentifier do

  Given(:doc) { load_xml "sender_identifier.xml" }

  describe "should correctly convert to a string" do
    Given(:id) { ONIX::SenderIdentifier.from_xml(doc) }
    Then { id.to_xml.to_s.start_with? "<SenderIdentifier>" }
  end

  describe "should provide read access to first level attributes" do
    Given(:id) { ONIX::SenderIdentifier.from_xml(doc) }

    Then { id.sender_id_type == 1 }
    Then { id.id_value == "123456" }
  end

  context "should provide write access to first level attributes" do
    Given(:id) { ONIX::SenderIdentifier.new }
    describe :sender_id_type= do
      When { id.sender_id_type = 1 }
      Then { id.to_xml.to_s.include? "<SenderIDType>01</SenderIDType>" }
    end
    describe :id_value= do
      When { id.id_value = "54321" }
      Then { id.to_xml.to_s.include? "<IDValue>54321</IDValue>" }
    end
  end

end
