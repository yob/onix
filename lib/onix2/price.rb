# coding: utf-8

module ONIX2
  class Price
    include Virtus.model

    attribute :price_type_code, Integer
    attribute :price_type_qualifier, Integer
    attribute :price_type_description
    attribute :price_per, Integer
    attribute :minimum_order_qty, Integer
    attribute :class_of_trade
    attribute :bic_discount_group_code
    attribute :discounts_coded, Array[DiscountCoded]
    attribute :price_status, Integer
    attribute :price_amount, Decimal
    attribute :currency_code
    attribute :discount_percent, Decimal

    def to_xml
      PriceRepresenter.new(self).to_xml
    end

    def self.from_xml(data)
      PriceRepresenter.new(self.new).from_xml(data)
    end
  end

  class PriceRepresenter < Representable::Decorator
    include Representable::XML

    self.representation_wrap = :Price

    property :price_type_code, as: "PriceTypeCode", render_filter: ::ONIX2::Formatters::TWO_DIGITS
    property :price_type_qualifier, as: "PriceQualifier", render_filter: ::ONIX2::Formatters::TWO_DIGITS
    property :price_type_description, as: "PriceTypeDescription"
    property :price_per, as: "PricePer", render_filter: ::ONIX2::Formatters::TWO_DIGITS
    property :minimum_order_qty, as: "MinimumOrderQuantity"
    property :class_of_trade, as: "ClassOfTrade"
    property :bic_discount_group_code, as: "BICDiscountGroupCode"
    collection :discounts_coded, as: "DiscountCoded", extend: ONIX2::DiscountCodedRepresenter, class: ONIX2::DiscountCoded
    property :price_status, as: "PriceStatus", render_filter: ::ONIX2::Formatters::TWO_DIGITS
    property :price_amount, as: "PriceAmount", render_filter: ::ONIX2::Formatters::DECIMAL
    property :currency_code, as: "CurrencyCode"
    property :discount_percent, as: "DiscountPercent"
  end
end
