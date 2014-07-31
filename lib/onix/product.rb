# coding: utf-8

module ONIX
  class Product
    include Virtus.model

    attribute :record_reference
    attribute :notification_type, Integer
    attribute :product_identifiers, Array[ONIX::ProductIdentifier]
    attribute :product_form
    attribute :product_form_detail
    attribute :series, Array[ONIX::Series]
    attribute :titles, Array[ONIX::Title]
    attribute :websites, Array[ONIX::Website]
    attribute :contributors, Array[ONIX::Contributor]
    attribute :edition_number, Integer
    attribute :languages, Array[ONIX::Language]
    attribute :number_of_pages, Integer
    attribute :basic_main_subject
    attribute :bic_main_subject
    attribute :subjects, Array[ONIX::Subject]
    attribute :audience_code
    attribute :audience_ranges, Array[ONIX::AudienceRange]
    attribute :text, Array[ONIX::OtherText]
    attribute :media_files, Array[ONIX::MediaFile]
    attribute :imprints, Array[ONIX::Imprint]
    attribute :publishers, Array[ONIX::Publisher]
    attribute :publishing_status, Integer
    attribute :publication_date
    attribute :copyright_year, Integer
    attribute :year_first_published, Integer
    attribute :sales_restrictions, Array[ONIX::SalesRestriction]
    attribute :measurements, Array[ONIX::Measure]
    attribute :supply_details, Array[ONIX::SupplyDetail]
    attribute :market_representations, Array[ONIX::MarketRepresentation]

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
    property :notification_type, as: "NotificationType", render_filter: ::ONIX::Formatters::TWO_DIGITS
    collection :product_identifiers, as: "ProductIdentifier", extend: ONIX::ProductIdentifierRepresenter, class: ONIX::ProductIdentifier
    property :product_form, as: "ProductForm"
    property :product_form_detail, as: "ProductFormDetail", render_filter: ::ONIX::Formatters::TWO_DIGITS
    collection :series, as: "Series", extend: ONIX::SeriesRepresenter, class: ONIX::Series
    collection :titles, as: "Title", extend: ONIX::TitleRepresenter, class: ONIX::Title
    collection :websites, as: "Website", extend: ONIX::WebsiteRepresenter, class: ONIX::Website
    collection :contributors, as: "Contributor", extend: ONIX::ContributorRepresenter, class: ONIX::Contributor
    property :edition_number, as: "EditionNumber"
    collection :languages, as: "Language", extend: ONIX::LanguageRepresenter, class: ONIX::Language
    property :number_of_pages, as: "NumberOfPages"
    property :basic_main_subject, as: "BASICMainSubject"
    property :bic_main_subject, as: "BICMainSubject"
    collection :subjects, as: "Subject", extend: ONIX::SubjectRepresenter, class: ONIX::Subject
    property :audience_code, as: "AudienceCode", render_filter: ::ONIX::Formatters::TWO_DIGITS
    collection :audience_ranges, as: "AudienceRange", extend: ONIX::AudienceRangeRepresenter, class: ONIX::AudienceRange
    collection :text, as: "OtherText", extend: ONIX::OtherTextRepresenter, class: ONIX::OtherText
    collection :media_files, as: "MediaFile", extend: ONIX::MediaFileRepresenter, class: ONIX::MediaFile
    collection :imprints, as: "Imprint", extend: ONIX::ImprintRepresenter, class: ONIX::Imprint
    collection :publishers, as: "Publisher", extend: ONIX::PublisherRepresenter, class: ONIX::Publisher
    property :publishing_status, as: "PublishingStatus", render_filter: ::ONIX::Formatters::TWO_DIGITS
    property :publication_date, as: "PublicationDate", render_filter: ::ONIX::Formatters::YYYYMMDD, parse_filter: ->(value, *context) { Date.parse(value) rescue nil }
    property :copyright_year, as: "CopyrightYear"
    property :year_first_published, as: "YearFirstPublished"
    collection :sales_restrictions, as: "SalesRestriction", extend: ONIX::SalesRestrictionRepresenter, class: ONIX::SalesRestriction
    collection :measurements, as: "Measure", extend: ONIX::MeasureRepresenter, class: ONIX::Measure
    collection :supply_details, as: "SupplyDetail", extend: ONIX::SupplyDetailRepresenter, class: ONIX::SupplyDetail
    collection :market_representations, as: "MarketRepresentation", extend: ONIX::MarketRepresentationRepresenter, class: ONIX::MarketRepresentation
    property :height, as: "Height"
    property :width, as: "Width"
    property :thickness, as: "Thickness"
    property :weight, as: "Weight"
    property :dimensions, as: "Dimensions"
  end
end
