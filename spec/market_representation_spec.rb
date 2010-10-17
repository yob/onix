# coding: utf-8

require File.dirname(__FILE__) + '/spec_helper.rb'

context "ONIX::MarketRepresentation" do

  before(:each) do
    data_path = File.join(File.dirname(__FILE__),"..","data")
    file1    = File.join(data_path, "market_representation.xml")
    @doc     = Nokogiri::XML::Document.parse(File.read(file1))
    @root = @doc.root
  end

  specify "should correctly convert to a string" do
    rep = ONIX::MarketRepresentation.from_xml(@root.to_s)
    rep.to_xml.to_s[0,22].should eql("<MarketRepresentation>")
  end

  specify "should provide read access to first level attributes" do
    rep = ONIX::MarketRepresentation.from_xml(@root.to_s)

    rep.agent_name.should eql("Allen & Unwin")
    rep.agent_role.should eql(7)
  end

  specify "should provide write access to first level attributes" do
    rep = ONIX::MarketRepresentation.new

    rep.agent_name = "Rainbow Book Agencies"
    rep.to_xml.to_s.include?("<AgentName>Rainbow Book Agencies</AgentName>").should be_true

    rep.agent_role = 3
    rep.to_xml.to_s.include?("<AgentRole>03</AgentRole>").should be_true

  end

end


