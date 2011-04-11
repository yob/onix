# coding: utf-8

module ONIX
  class Price
    include ROXML

    xml_name "Price"

    xml_accessor :price_type_code, :from => "PriceTypeCode", :as => Fixnum, :to_xml => ONIX::Formatters.two_digit
    xml_accessor :price_type_qualifier, :from => "PriceQualifier", :as => Fixnum, :to_xml => ONIX::Formatters.two_digit
    xml_accessor :price_type_description, :from => "PriceTypeDescription"
    xml_accessor :price_per, :from => "PricePer", :as => Fixnum, :to_xml => ONIX::Formatters.two_digit
    xml_accessor :minimum_order_qty, :from => "MinimumOrderQuantity", :as => Fixnum
    xml_accessor :class_of_trade, :from => "ClassOfTrade"
    xml_accessor :bic_discount_group_code, :from => "BICDiscountGroupCode"
    xml_accessor :price_status, :from => "PriceStatus", :as => Fixnum, :to_xml => ONIX::Formatters.two_digit
    xml_accessor :price_amount, :from => "PriceAmount", :as => BigDecimal, :to_xml => ONIX::Formatters.decimal
    xml_accessor :currency_code, :from => "CurrencyCode"
  end
end
