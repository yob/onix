module ONIX
  class MarketRepresentation
    include ROXML

    xml_accessor :agent_name, :etext, :from => "AgentName"
    xml_accessor :agent_role, :twodigit, :from => "AgentRole"
    xml_accessor :market_country, :etext, :from => "MarketCountry"
    xml_accessor :market_territory, :etext, :from => "MarketTerritory"
    xml_accessor :market_country_excluded, :etext, :from => "MarketCountryExcluded"
    xml_accessor :market_restriction_detail, :etext, :from => "MarketRestrictionDetail"
    xml_accessor :market_publishing_status, :twodigit, :from => "MarketPublishingStatus"
  end
end

