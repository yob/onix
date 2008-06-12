module ONIX
  class Product
    include XML::Mapping

    text_node    :record_reference,    "RecordReference"
    numeric_node :notification_type,   "NotificationType"
    array_node   :product_identifiers, "ProductIdentifier", :class => ONIX::ProductIdentifier
    text_node    :product_form,        "ProductForm",       :optional => true
    text_node    :series,              "Series",            :optional => true
    text_node    :edition,             "Edition",           :optional => true
    array_node   :titles,              "Title",             :optional => true, :class => ONIX::Title
    array_node   :websites,            "Website",           :optional => true, :class => ONIX::Website
    array_node   :contributors,        "Contributor",       :optional => true, :class => ONIX::Contributor
    numeric_node :number_of_pages,     "NumberOfPages",     :optional => true
    text_node    :bic_main_subject,    "BICMainSubject",    :optional => true
    array_node   :imprints,            "Imprint",           :optional => true, :class => ONIX::Imprint
    array_node   :publishers,          "Publisher",         :optional => true, :class => ONIX::Publisher
    numeric_node :publishing_status,   "PublishingStatus",  :optional => true
    text_node    :publication_date,    "PublicationDate",   :optional => true
    array_node   :sales_restrictions,  "SalesRestriction",  :optional => true, :class => ONIX::SalesRestriction
    array_node   :supply_details,      "SupplyDetail",      :optional => true, :class => ONIX::SupplyDetail

    def isbn13
      product_identifiers.each do |id|
        return id.id_value if id.product_id_type == 2
      end
      return nil
    end

    def title
      titles.each do |title|
        return title.title_text if title.title_type == 3
      end
      return nil
    end
  end
end
