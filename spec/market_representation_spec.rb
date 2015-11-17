# coding: utf-8

require 'spec_helper'

describe ONIX2::MarketRepresentation do

  Given(:doc) { load_xml "market_representation.xml" }

  describe "should correctly convert to a string" do
    Given(:rep) { ONIX2::MarketRepresentation.from_xml(doc) }
    Then { rep.to_xml.to_s.start_with? "<MarketRepresentation>" }
  end

  describe "should provide read access to first level attributes" do
    Given(:rep) { ONIX2::MarketRepresentation.from_xml(doc) }

    Then { rep.agent_name == "Allen & Unwin" }
    Then { rep.agent_role == 7 }
  end

  context "should provide write access to first level attributes" do
    Given(:rep) { ONIX2::MarketRepresentation.new }
    describe :agent_name= do
      When { rep.agent_name = "Rainbow Book Agencies" }
      Then { rep.to_xml.to_s.include? "<AgentName>Rainbow Book Agencies</AgentName>" }
    end
    describe :agent_role= do
      When { rep.agent_role = 3 }
      Then { rep.to_xml.to_s.include? "<AgentRole>03</AgentRole>" }
    end
  end

end
