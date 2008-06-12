module ONIX
  class Product
    include XML::Mapping

    root_element_name "Product"

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

    def initialize
      # setup some default values for when the object is created from scratch
      self.product_identifiers = []
      self.titles = []
      self.websites = []
      self.contributors = []
      self.imprints = []
      self.publishers = []
      self.sales_restrictions = []
      self.supply_details = []
    end
  end
end
