module ONIX
  class Product
    include ROXML

    xml_name "Product"

    xml_accessor :record_reference, :from => "RecordReference"
    xml_accessor :notification_type, :twodigit, :from => "NotificationType"
    xml_accessor :product_identifiers, [ONIX::ProductIdentifier], :from => "ProductIdentifier"
    xml_accessor :product_form, :from => "ProductForm"
    xml_accessor :series, :from => "Series"
    xml_accessor :edition, :from => "Edition"
    xml_accessor :titles, [ONIX::Title], :from => "Title"
    xml_accessor :websites, [ONIX::Website], :from => "Website"
    xml_accessor :contributors, [ONIX::Contributor], :from => "Contributor"
    xml_accessor :number_of_pages, :from => "NumberOfPages"
    xml_accessor :bic_main_subject, :from => "BICMainSubject"
    xml_accessor :subjects, [ONIX::Subject], :from => "Subject"
    xml_accessor :text, [ONIX::OtherText], :from => "OtherText"
    xml_accessor :media_files, [ONIX::MediaFile], :from => "MediaFile"
    xml_accessor :imprints, [ONIX::Imprint], :from => "Imprint"
    xml_accessor :publishers, [ONIX::Publisher], :from => "Publisher"
    xml_accessor :publishing_status, :twodigit, :from => "PublishingStatus"
    xml_accessor :publication_date, :yyyymmdd, :from => "PublicationDate"
    xml_accessor :sales_restrictions, [ONIX::SalesRestriction], :from => "SalesRestriction"
    xml_accessor :supply_details, [ONIX::SupplyDetail], :from => "SupplyDetail"

  end
end
