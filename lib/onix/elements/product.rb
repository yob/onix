# coding: utf-8

module ONIX
  class Product < ONIX::Element

    xml_name "Product"

    # PR.1 Record reference number, type and source
    xml_accessor :record_reference, :from => "RecordReference"
    onix_code_from_list :notification_type, "NotificationType", :list => 1
    onix_code_from_list :deletion_code, "DeletionCode", :list => 2
    xml_accessor :deletion_text, :from => "DeletionText"
    onix_code_from_list :record_source_type, "RecordSourceType", :list => 3
    # FIXME: List 4 is missing?
    # onix_code_from_list :record_source_identifier_type, "RecordSourceIdentifierType", :list => 4
    xml_accessor :record_source_identifier, :from => "RecordSourceIdentifier"
    xml_accessor :record_source_name, :from => "RecordSourceName"

    # PR.2 Product numbers
    onix_composite :product_identifiers, ONIX::ProductIdentifier
    onix_codes_from_list :barcodes, "Barcode", :list => 6

    # PR.3 Product Form
    onix_code_from_list :product_form, "ProductForm", :list => 7
    onix_codes_from_list :product_form_details, "ProductFormDetail", :list => 78
    # TODO: onix_composite :product_form_features, ONIX::ProductFormFeature
    onix_code_from_list :product_packaging, "ProductPackaging", :list => 80
    xml_accessor :product_form_description, :from => "ProductFormDescription"
    xml_accessor :number_of_pieces, :from => "NumberOfPieces", :as => Fixnum
    onix_code_from_list :trade_category, "TradeCategory", :list => 12
    onix_code_from_list :product_content_type, "ProductContentType", :list => 81

    # TODO: onix_composite :contained_items, ONIX::ContainedItem
    # TODO: onix_composite :product_classifications, ONIX::ProductClassification

    # PR.4 Epublication
    onix_code_from_list :epub_type, "EpubType", :list => 10
    xml_accessor :epub_type_version, "EpubTypeVersion"
    xml_accessor :epub_type_description, "EpubTypeDescription"
    onix_code_from_list :epub_format, "EpubFormat", :list => 11
    xml_accessor :epub_format_version, "EpubFormatVersion"
    xml_accessor :epub_format_description, "EpubFormatDescription"
    onix_code_from_list :epub_source, "EpubSource", :list => 11
    xml_accessor :epub_source_version, "EpubSourceVersion"
    xml_accessor :epub_source_description, "EpubSourceDescription"
    xml_accessor :epub_type_note, "EpubTypeNote"

    onix_composite :series, ONIX::Series

    # PR.6 Set
    # TODO: onix_composite :sets, ONIX::Set

    # PR.7 Title
    onix_composite :titles, ONIX::Title
    # TODO: onix_composite :work_identifiers, ONIX::WorkIdentifier
    onix_composite :websites, ONIX::Website
    onix_code_from_list :thesis_type, "ThesisType", :list => 72
    xml_accessor :thesis_presented_to, "ThesisPresentedTo"
    xml_accessor :year_of_thesis, "YearOfThesis", :as => Fixnum

    # PR.8 Authorship
    onix_composite :contributors, ONIX::Contributor

    # PR.9 Conference
    # TODO: onix_composite :conferences, ONIX::Conference

    # PR.10 Edition
    onix_code_from_list :edition_type_code, "EditionTypeCode", :list => 21
    xml_accessor :edition_number, :from => "EditionNumber", :as => Fixnum
    xml_accessor :edition_version_number, :from => "EditionVersionNumber"
    xml_accessor :edition_statement, :from => "EditionStatement"
    # FIXME: NoEdition is an empty element flag. How to capture this?
    # TODO: onix_composite :religious_text, ONIX::ReligiousText, :singular => true

    # PR.11 Language
    onix_composite :languages, ONIX::Language

    # PR.12 Extents and other content
    xml_accessor :number_of_pages, :from => "NumberOfPages", :as => Fixnum
    xml_accessor :pages_roman, :from => "PagesRoman"
    xml_accessor :pages_arabic, :from => "PagesArabic", :as => Fixnum
    # TODO: onix_composite :extents, ONIX::Extent
    xml_accessor :number_of_illustrations, :from => "NumberOfIllustrations", :as => Fixnum
    xml_accessor :illustrations_note, :from => "IllustrationsNote"
    # TODO: onix_composite :illustrations, ONIX::Illustrations
    xml_accessor :map_scale, :from => "MapScale", :as => [Fixnum]

    # PR.13 Subject
    xml_accessor :basic_main_subject, :from => "BASICMainSubject"
    xml_accessor :bic_main_subject, :from => "BICMainSubject"
    # TODO: onix_composite :main_subject, ONIX::MainSubject
    onix_composite :subjects, ONIX::Subject
    onix_composite :person_as_subjects, ONIX::Contributor, :from => "PersonAsSubject"
    xml_accessor :corporate_body_as_subject, :from => "CorporateBodyAsSubject", :as => []
    xml_accessor :place_as_subject, :from => "PlaceAsSubject", :as => []

    # PR.14 Audience
    onix_codes_from_list :audience_codes, "AudienceCode", :list => 28
    # TODO: onix_composite :audiences, ONIX::Audience
    onix_composite :audience_ranges, ONIX::AudienceRange
    xml_accessor :audience_description, :from => "AudienceDescription"
    # TODO: onix_composite :complexities, ONIX::Complexity

    # PR.15 Descriptions and supporting texts
    # FIXME: should this be :text, :texts or :other_texts? Can we alias?
    onix_composite :text, ONIX::OtherText

    # PR.16 Links to image/audio/video files
    onix_composite :media_files, ONIX::MediaFile
    onix_composite :product_websites, ONIX::Website, :from => "ProductWebsite"

    # PR.17 Prizes
    # TODO: onix_composite :prizes, ONIX::Prize

    # PR.18 Content items
    # TODO: onix_composite :content_items, ONIX::ContentItem

    # PR.19 Publisher
    onix_composite :imprints, ONIX::Imprint
    onix_composite :publishers, ONIX::Publisher
    xml_accessor :cities_of_publication, :from => "CityOfPublication", :as => []
    onix_code_from_list :country_of_publication, "CountryOfPublication", :list => 91

    # PR.20 Publishing status and dates, and copyright
    onix_code_from_list :publishing_status, "PublishingStatus", :list => 64
    xml_accessor :publishing_status_note, :from => "PublishingStatusNote"
    onix_date_accessor :announcement_date, "AnnouncementDate"
    onix_date_accessor :trade_announcement_date, "TradeAnnouncementDate"
    onix_date_accessor :publication_date, "PublicationDate"
    # TODO: onix_composite :copyright_statements, ONIX::CopyrightStatement
    xml_accessor :copyright_year, :from => "CopyrightYear", :as => Fixnum
    xml_accessor :year_first_published, :from => "YearFirstPublished", :as => Fixnum

    # PR.21 Territorial rights and other sales restrictions
    onix_composite :sales_rights, ONIX::SalesRights
    onix_composite :not_for_sales, ONIX::NotForSale
    onix_composite :sales_restrictions, ONIX::SalesRestriction

    # PR.22 Dimensions
    # FIXME: rename to :measures?
    onix_composite :measurements, ONIX::Measure
    # Some deprecated attributes. Read only
    # - See the measurements array for the current way of specifying
    #   various measurements of the product
    xml_reader :height,     :from => "Height", :as => BigDecimal
    xml_reader :width,      :from => "Width", :as => BigDecimal
    xml_reader :thickness,  :from => "Thickness", :as => BigDecimal
    xml_reader :weight,     :from => "Weight", :as => BigDecimal
    xml_reader :dimensions, :from => "Dimensions"

    # PR.23 Related products
    onix_composite :related_products, ONIX::Product, :from => "RelatedProduct"
    onix_code_from_list :relation_code, "RelationCode", :list => 51
    onix_date_accessor :out_of_print_date, "OutOfPrintDate"

    # PR.24 Supplier, availability and prices
    onix_composite :supply_details, ONIX::SupplyDetail

    # PR.25 Market representation
    onix_composite :market_representations, ONIX::MarketRepresentation

    # PR.26 Sales promotion information
    xml_accessor :promotion_campaign, :from => "PromotionCampaign"
    xml_accessor :promotion_contact_details, :from => "PromotionContactDetails"
    xml_accessor :initial_print_run, :from => "InitialPrintRun"
    xml_accessor :reprint_details, :from => "ReprintDetail", :as => []
    xml_accessor :copies_sold, :from => "CopiesSold"
    xml_accessor :book_club_adoption, :from => "BookClubAdoption"


    def initialize
      self.product_identifiers = []
      self.series = []
      self.titles = []
      self.contributors = []
      self.websites = []
      self.subjects = []
      self.audience_ranges = []
      self.text = []
      self.languages = []
      self.media_files = []
      self.imprints = []
      self.publishers = []
      self.sales_restrictions = []
      self.measurements = []
      self.supply_details = []
      self.market_representations = []
    end

    # Extend this product instance with a module. Typically these modules
    # make it easier to read or write common values in the Product.
    #
    # The product tracks the modules that have extended it, so that it
    # can easily pass these extensions on to other products
    # (see #interpret_like_me).
    #
    # For convenience, this method returns the product itself.
    #
    def interpret(mods)
      @_extensions ||= []
      [mods].flatten.compact.uniq.each { |mod|
        next  if @_extensions.include?(mod)
        @_extensions << mod
        extend(mod)
      }
      self
    end

    # Apply all the modules that have extended this product to another product.
    #
    # This is useful when, say, accessing RelatedProduct or ContainedItem
    # composites. Your module might do something like:
    #
    #   def print_product
    #     prod = related_products.detect { |p| p.relation_code == 13 }
    #     prod ? interpret_like_me(prod) : nil
    #   end
    #
    # As a result, this related product will have all the extensions applied
    # to this product.
    #
    def interpret_like_me(product)
      product.interpret(@_extensions)
    end

  end
end
