# coding: utf-8

class ONIX::MarketRepresentation < ONIX::Element
  xml_name "MarketRepresentation"
  onix_composite :agent_identifiers, ONIX::AgentIdentifier
  xml_accessor :agent_name, :from => "AgentName"
  xml_accessor :telephone_number, :from => "TelephoneNumber"
  xml_accessor :fax_number, :from => "FaxNumber"
  xml_accessor :email_address, :from => "EmailAddress"
  onix_composite :websites, ONIX::Website
  onix_code_from_list :agent_role, "AgentRole", :list => 69
  xml_accessor :market_country, :from => "MarketCountry"
  xml_accessor :market_territory, :from => "MarketTerritory"
  xml_accessor :market_country_excluded, :from => "MarketCountryExcluded"
  xml_accessor :market_restriction_detail, :from => "MarketRestrictionDetail"
  onix_code_from_list :market_publishing_status, "MarketPublishingStatus", :list => 68
  onix_composite :market_dates, ONIX::MarketDate
end
