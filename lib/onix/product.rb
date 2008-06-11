module ONIX
  class Product
    include XML::Mapping

    text_node    :record_reference,    "RecordReference"
    numeric_node :notification_type,   "NotificationType"
    array_node   :product_identifiers, "ProductIdentifier", :class => ONIX::ProductIdentifier
    text_node    :product_form,        "ProductForm"
    text_node    :series,              "Series",            :optional => true
    text_node    :edition,             "Edition",           :optional => true
    array_node   :titles,              "Title",             :class => ONIX::Title

    def best_id
      values = {}
      product_identifiers.each do |id|
        values[id.product_id_type] = id.id_value
      end
      values[3] || values[2] || values[1]
    end

    def best_title
      values = {}
      titles.each do |title|
        values[title.title_type] = title.title_text
      end
      values[3] || values[2] || values[1]
    end
  end
end
