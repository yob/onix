module ONIX
  class MarketRepresentation
    include ROXML

    xml_accessor :agent_name, :from => "AgentName"
    xml_accessor :agent_role, :from => "AgentRole", :as => Integer # should be a 2 digit num
    xml_accessor :market_country, :from => "MarketCountry"
    xml_accessor :market_territory, :from => "MarketTerritory"
    xml_accessor :market_country_excluded, :from => "MarketCountryExcluded"
    xml_accessor :market_restriction_detail, :from => "MarketRestrictionDetail"
    xml_accessor :market_publishing_status, :from => "MarketPublishingStatus", :as => Integer # should be a 2 digit num
  end
end

