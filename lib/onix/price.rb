module ONIX
  class Price
    include ROXML

    xml_accessor :price_type_code, :from => "PriceTypeCode"
    xml_accessor :price_type_qualifier, :from => "PriceTypeQualifier"
    xml_accessor :price_type_description, :from => "PriceTypeDescription"
    xml_accessor :price_per, :from => "PricePer"
    xml_accessor :minimum_order_qty, :from => "MinimumOrderQuantity"
    xml_accessor :class_of_trade, :from => "ClassOfTrade"
    xml_accessor :bic_discount_group_code, :from => "BICDiscountGroupCode"
    xml_accessor :price_status, :from => "PriceStatus"
    xml_accessor :price_amount, :from => "PriceAmount"
    xml_accessor :currency_code, :from => "CurrencyCode"
  end
end
