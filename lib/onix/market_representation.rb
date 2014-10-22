# coding: utf-8

module ONIX2
  class MarketRepresentation
    include Virtus.model

    attribute :agent_name
    attribute :agent_role, Integer
    attribute :market_country
    attribute :market_territory
    attribute :market_country_excluded
    attribute :market_restriction_detail
    attribute :market_publishing_status, Integer

    def to_xml
      MarketRepresentationRepresenter.new(self).to_xml
    end

    def self.from_xml(data)
      MarketRepresentationRepresenter.new(self.new).from_xml(data)
    end
  end

  class MarketRepresentationRepresenter < Representable::Decorator
    include Representable::XML

    self.representation_wrap = :MarketRepresentation

    property :agent_name, as: "AgentName"
    property :agent_role, as: "AgentRole", render_filter: ::ONIX2::Formatters::TWO_DIGITS
    property :market_country, as: "MarketCountry"
    property :market_territory, as: "MarketTerritory"
    property :market_country_excluded, as: "MarketCountryExcluded"
    property :market_restriction_detail, as: "MarketRestrictionDetail"
    property :market_publishing_status, as: "MarketPublishingStatus", render_filter: ::ONIX2::Formatters::TWO_DIGITS
  end
end

