module ONIX
  class Product
    include ROXML

    xml_name "Product"

    two_digit = lambda do |val|
      if val.nil?
        nil
      elsif val < 10
        "0#{val}"
      elsif val > 99
        val.to_s[-2,2]
      else
        val.to_s
      end
    end

    yyyymmdd = lambda do |val|
      if val.nil? || !val.respond_to?(:strftime)
        nil
      else
        val.strftime("%Y%m%d")
      end
    end

    xml_accessor :record_reference, :from => "RecordReference"
    xml_accessor :notification_type, :as => Fixnum, :to_xml => two_digit, :from => "NotificationType" # should be a 2 digit num
    xml_accessor :product_identifiers, :from => "ProductIdentifier", :as => [ONIX::ProductIdentifier]
    xml_accessor :product_form, :from => "ProductForm"
    xml_accessor :series, :from => "Series"
    xml_accessor :edition_number, :from => "EditionNumber", :as => Fixnum
    xml_accessor :titles, :from => "Title", :as => [ONIX::Title]
    xml_accessor :contributors, :from => "Contributor", :as => [ONIX::Contributor]
    xml_accessor :websites, :from => "Website", :as => [ONIX::Website]
    xml_accessor :number_of_pages, :from => "NumberOfPages", :as => Fixnum
    xml_accessor :bic_main_subject, :from => "BICMainSubject"
    xml_accessor :subjects, :from => "Subject", :as => [ONIX::Subject]
    xml_accessor :text, :from => "OtherText", :as => [ONIX::OtherText]
    xml_accessor :media_files, :from => "MediaFile", :as => [ONIX::MediaFile]
    xml_accessor :imprints, :from => "Imprint", :as => [ONIX::Imprint]
    xml_accessor :publishers, :from => "Publisher", :as => [ONIX::Publisher]
    xml_accessor :publishing_status, :as => Fixnum, :to_xml => two_digit, :from => "PublishingStatus" # should be a 2 digit num
    xml_accessor :publication_date, :from => "PublicationDate", :as => Date, :to_xml => yyyymmdd
    xml_accessor :year_first_published, :from => "YearFirstPublished", :as => Fixnum
    xml_accessor :sales_restrictions, :from => "SalesRestriction", :as => [ONIX::SalesRestriction]
    xml_accessor :measurements, :from => "Measure", :as => [ONIX::Measure]
    xml_accessor :supply_details, :from => "SupplyDetail", :as => [ONIX::SupplyDetail]
    xml_accessor :market_representations, :from => "MarketRepresentation", :as => [ONIX::MarketRepresentation]

    # some deprecated attributes. Read only
    # - See the measures array for the current way of specifying
    #   various measurements of the product
    xml_reader :height,     :from => "Height", :as => BigDecimal
    xml_reader :width,      :from => "Width", :as => BigDecimal
    xml_reader :thickness,  :from => "Thickness", :as => BigDecimal
    xml_reader :weight,     :from => "Weight", :as => BigDecimal
    xml_reader :dimensions, :from => "Dimensions"

  end
end
