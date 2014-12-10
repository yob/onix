# coding: utf-8

module ONIX2
  class Product
    include Virtus.model

    attribute :record_reference
    attribute :notification_type, Integer
    attribute :product_identifiers, Array[ONIX2::ProductIdentifier]
    attribute :product_form
    attribute :product_form_detail
    attribute :series, Array[ONIX2::Series]
    attribute :titles, Array[ONIX2::Title]
    attribute :websites, Array[ONIX2::Website]
    attribute :contributors, Array[ONIX2::Contributor]
    attribute :edition_number, Integer
    attribute :languages, Array[ONIX2::Language]
    attribute :number_of_pages, Integer
    attribute :basic_main_subject
    attribute :bic_main_subject
    attribute :subjects, Array[ONIX2::Subject]
    attribute :audience_code
    attribute :audience_ranges, Array[ONIX2::AudienceRange]
    attribute :text, Array[ONIX2::OtherText]
    attribute :media_files, Array[ONIX2::MediaFile]
    attribute :imprints, Array[ONIX2::Imprint]
    attribute :publishers, Array[ONIX2::Publisher]
    attribute :publishing_status, Integer
    attribute :publication_date
    attribute :copyright_year, Integer
    attribute :year_first_published, Integer
    attribute :sales_restrictions, Array[ONIX2::SalesRestriction]
    attribute :measurements, Array[ONIX2::Measure]
    attribute :supply_details, Array[ONIX2::SupplyDetail]
    attribute :market_representations, Array[ONIX2::MarketRepresentation]
    attribute :sales_rights, Array[ONIX2::SalesRights]
    attribute :epub_type

    # some deprecated attributes. Read only
    # - See the measures array for the current way of specifying
    #   various measurements of the product
    attribute :height, Decimal
    attribute :width, Decimal
    attribute :thickness, Decimal
    attribute :weight, Decimal
    attribute :dimensions

    def to_xml
      ProductRepresenter.new(self).to_xml
    end

    def self.from_xml(data)
      ProductRepresenter.new(self.new).from_xml(data)
    end
  end

  class ProductRepresenter < Representable::Decorator
    include Representable::XML

    self.representation_wrap = :Product

    property :record_reference, as: "RecordReference"
    property :notification_type, as: "NotificationType", render_filter: ::ONIX2::Formatters::TWO_DIGITS
    collection :product_identifiers, as: "ProductIdentifier", extend: ONIX2::ProductIdentifierRepresenter, class: ONIX2::ProductIdentifier
    property :product_form, as: "ProductForm"
    property :product_form_detail, as: "ProductFormDetail", render_filter: ::ONIX2::Formatters::TWO_DIGITS
    collection :series, as: "Series", extend: ONIX2::SeriesRepresenter, class: ONIX2::Series
    collection :titles, as: "Title", extend: ONIX2::TitleRepresenter, class: ONIX2::Title
    collection :websites, as: "Website", extend: ONIX2::WebsiteRepresenter, class: ONIX2::Website
    collection :contributors, as: "Contributor", extend: ONIX2::ContributorRepresenter, class: ONIX2::Contributor
    property :edition_number, as: "EditionNumber"
    collection :languages, as: "Language", extend: ONIX2::LanguageRepresenter, class: ONIX2::Language
    property :number_of_pages, as: "NumberOfPages"
    property :basic_main_subject, as: "BASICMainSubject"
    property :bic_main_subject, as: "BICMainSubject"
    collection :subjects, as: "Subject", extend: ONIX2::SubjectRepresenter, class: ONIX2::Subject
    property :audience_code, as: "AudienceCode", render_filter: ::ONIX2::Formatters::TWO_DIGITS
    collection :audience_ranges, as: "AudienceRange", extend: ONIX2::AudienceRangeRepresenter, class: ONIX2::AudienceRange
    collection :text, as: "OtherText", extend: ONIX2::OtherTextRepresenter, class: ONIX2::OtherText
    collection :media_files, as: "MediaFile", extend: ONIX2::MediaFileRepresenter, class: ONIX2::MediaFile
    collection :imprints, as: "Imprint", extend: ONIX2::ImprintRepresenter, class: ONIX2::Imprint
    collection :publishers, as: "Publisher", extend: ONIX2::PublisherRepresenter, class: ONIX2::Publisher
    property :publishing_status, as: "PublishingStatus", render_filter: ::ONIX2::Formatters::TWO_DIGITS
    property :publication_date, as: "PublicationDate", render_filter: ::ONIX2::Formatters::YYYYMMDD, parse_filter: ->(value, *context) { Date.parse(value) rescue nil }
    property :copyright_year, as: "CopyrightYear"
    property :year_first_published, as: "YearFirstPublished"
    collection :sales_restrictions, as: "SalesRestriction", extend: ONIX2::SalesRestrictionRepresenter, class: ONIX2::SalesRestriction
    collection :measurements, as: "Measure", extend: ONIX2::MeasureRepresenter, class: ONIX2::Measure
    collection :supply_details, as: "SupplyDetail", extend: ONIX2::SupplyDetailRepresenter, class: ONIX2::SupplyDetail
    collection :market_representations, as: "MarketRepresentation", extend: ONIX2::MarketRepresentationRepresenter, class: ONIX2::MarketRepresentation
    property :height, as: "Height"
    property :width, as: "Width"
    property :thickness, as: "Thickness"
    property :weight, as: "Weight"
    property :dimensions, as: "Dimensions"
    collection :sales_rights, as: "SalesRights", extend: ONIX2::SalesRightsRepresenter, class: ONIX2::SalesRights
    property :epub_type, as: "EpubType"
  end
end
