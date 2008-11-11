module ONIX
  class Product
    include ROXML

    xml_name "Product"

    xml_accessor :record_reference, :from => "RecordReference"
    xml_accessor :notification_type, :twodigit, :from => "NotificationType"
    xml_accessor :product_identifiers, [ONIX::ProductIdentifier], :from => "ProductIdentifier"
    xml_accessor :product_form, :from => "ProductForm"
    xml_accessor :series, :from => "Series"
    xml_accessor :edition_number, :integer, :from => "EditionNumber"
    xml_accessor :titles, [ONIX::Title], :from => "Title"
    xml_accessor :contributors, [ONIX::Contributor], :from => "Contributor"
    xml_accessor :websites, [ONIX::Website], :from => "Website"
    xml_accessor :number_of_pages, :integer, :from => "NumberOfPages"
    xml_accessor :bic_main_subject, :from => "BICMainSubject"
    xml_accessor :subjects, [ONIX::Subject], :from => "Subject"
    xml_accessor :text, [ONIX::OtherText], :from => "OtherText"
    xml_accessor :media_files, [ONIX::MediaFile], :from => "MediaFile"
    xml_accessor :imprints, [ONIX::Imprint], :from => "Imprint"
    xml_accessor :publishers, [ONIX::Publisher], :from => "Publisher"
    xml_accessor :publishing_status, :twodigit, :from => "PublishingStatus"
    xml_accessor :publication_date, :yyyymmdd, :from => "PublicationDate"
    xml_accessor :year_first_published, :integer, :from => "YearFirstPublished"
    xml_accessor :sales_restrictions, [ONIX::SalesRestriction], :from => "SalesRestriction"
    xml_accessor :measurements, [ONIX::Measure], :from => "Measure"
    xml_accessor :supply_details, [ONIX::SupplyDetail], :from => "SupplyDetail"
    xml_accessor :market_representations, [ONIX::MarketRepresentation], :from => "MarketRepresentation"

    # some deprecated attributes. Read only
    # - See the measures array for the current way of specifying
    #   various measurements of the product
    xml_reader :height,    :decimal, :from => "Height"
    xml_reader :width,     :decimal, :from => "Width"
    xml_reader :thickness, :decimal, :from => "Thickness"
    xml_reader :weight,    :decimal, :from => "Weight"
    xml_reader :dimensions, :etext,  :from => "Dimensions"

  end
end
