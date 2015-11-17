# coding: utf-8

module ONIX2
  class SupplyDetail
    include Virtus.model

    attribute :supplier_ean_location_number
    attribute :supplier_san
    attribute :supplier_name
    attribute :telephone_number
    attribute :fax_number
    attribute :email_address
    attribute :websites, Array[ONIX2::Website]
    attribute :supplier_role, Integer
    attribute :supply_to_country
    attribute :supply_to_territory
    attribute :availability_status_code, Integer
    attribute :product_availability, Integer
    attribute :stock, Array[ONIX2::Stock]
    attribute :pack_quantity, Integer
    attribute :prices, Array[ONIX2::Price]

    def to_xml
      SupplyDetailRepresenter.new(self).to_xml
    end

    def self.from_xml(data)
      SupplyDetailRepresenter.new(self.new).from_xml(data)
    end
  end

  class SupplyDetailRepresenter < Representable::Decorator
    include Representable::XML

    self.representation_wrap = :SupplyDetail

    property :supplier_ean_location_number, as: "SupplierEANLocationNumber"
    property :supplier_san, as: "SupplierSAN"
    property :supplier_name, as: "SupplierName"
    property :telephone_number, as: "TelephoneNumber"
    property :fax_number, as: "FaxNumber"
    property :email_address, as: "EmailAddress"
    collection :websites, as: "Website", extend: ONIX2::WebsiteRepresenter, class: ONIX2::Website
    property :supplier_role, as: "SupplierRole", render_filter: ::ONIX2::Formatters::TWO_DIGITS
    property :supply_to_country, as: "SupplyToCountry"
    property :supply_to_territory, as: "SupplyToTerritory"
    property :availability_status_code, as: "AvailabilityStatusCode", render_filter: ::ONIX2::Formatters::TWO_DIGITS
    property :product_availability, as: "ProductAvailability", render_filter: ::ONIX2::Formatters::TWO_DIGITS
    collection :stock, as: "Stock", extend: ONIX2::StockRepresenter, class: ONIX2::Stock
    property :pack_quantity, as: "PackQuantity"
    collection :prices, as: "Price", extend: ONIX2::PriceRepresenter, class: ONIX2::Price
  end
end
