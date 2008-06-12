module ONIX
  class Price
    include XML::Mapping

    numeric_node :price_type_code,  "PriceTypeCode", :optional => true
    numeric_node :price_type_qualifier, "PriceTypeQualifier", :optional => true
    text_node    :price_type_description, "PriceTypeDescription", :optional => true
    numeric_node :price_per,  "PricePer", :optional => true
    numeric_node :minimum_order_qty,  "MinimumOrderQuantity", :optional => true
    text_node    :class_of_trade,  "ClassOfTrade", :optional => true
    text_node    :bic_discount_group_code, "BICDiscountGroupCode", :optional => true
    numeric_node :price_status, "PriceStatus", :optional => true
    numeric_node :price_amount, "PriceAmount", :optional => true
    text_node    :currency_code, "CurrencyCode", :optional => true
  end
end
