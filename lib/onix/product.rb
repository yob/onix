module ONIX
  class Product
    include ROXML

    xml_accessor :record_reference, :from => "RecordReference"
    xml_accessor :notification_type, :from => "NotificationType"
    xml_accessor :product_identifiers, [ONIX::ProductIdentifier], :from => "ProductIdentifier"
    xml_accessor :product_form, :from => "ProductForm"
    xml_accessor :series, :from => "Series"
    xml_accessor :edition, :from => "Edition"
    xml_accessor :titles, [ONIX::Title], :from => "Title"
    xml_accessor :websites, [ONIX::Website], :from => "Website"
    xml_accessor :contributors, [ONIX::Contributor], :from => "Contributor"
    xml_accessor :number_of_pages, :from => "NumberOfPages"
    xml_accessor :bic_main_subject, :from => "BICMainSubject"
    #array_node     :subjects,            "Subject",           , :class => ONIX::Subject
    #array_node     :text,                "OtherText",         , :class => ONIX::OtherText
    #array_node     :media_files,         "MediaFile",         , :class => ONIX::MediaFile
    #array_node     :imprints,            "Imprint",           , :class => ONIX::Imprint
    #array_node     :publishers,          "Publisher",         , :class => ONIX::Publisher
    xml_accessor :publishing_status, :from => "PublishingStatus"
    xml_accessor :publication_date, :from => "PublicationDate"
    #array_node     :sales_restrictions,  "SalesRestriction",  , :class => ONIX::SalesRestriction
    #array_node     :supply_details,      "SupplyDetail",      , :class => ONIX::SupplyDetail

  end
end
