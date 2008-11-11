module ONIX
  class MarketRepresentation
    include ROXML

    xml_accessor :agent_name, :etext, :from => "AgentName"
    xml_accessor :market_publishing_status, :twodigit, :from => "MarketPublishingStatus"
  end
end

