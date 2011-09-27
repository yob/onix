# coding: utf-8

module ONIX
  class Price < ONIX::Element
    xml_name "Price"


    def self.onix_decimal_accessor(name, tag_name)
      options = {
        :from => tag_name,
        :as => BigDecimal,
        :to_xml => ONIX::Formatters.decimal
      }
      xml_accessor(name, options)
    end


    onix_code_from_list :price_type_code, "PriceTypeCode", :list => 58
    onix_code_from_list :price_type_qualifier, "PriceTypeQualifier", :list => 59
    xml_accessor :price_type_description, :from => "PriceTypeDescription"
    onix_code_from_list :price_per, "PricePer", :list => 60
    xml_accessor :minimum_order_qty, :from => "MinimumOrderQuantity", :as => Fixnum
    onix_composite :batch_bonuses, ONIX::BatchBonus
    xml_accessor :class_of_trade, :from => "ClassOfTradeCode"
    xml_accessor :bic_discount_group_code, :from => "BICDiscountGroupCode"
    onix_composite :discount_codeds, ONIX::DiscountCoded
    onix_decimal_accessor :discount_percentage, "DiscountPercentage"
    onix_code_from_list :price_status, "PriceStatus", :list => 61
    onix_decimal_accessor :price_amount, "PriceAmount"
    onix_code_from_list :currency_code, "CurrencyCode", :list => 96

    # FIXME: should be repeatable, and most of these attributes
    # should be validated against lists 91 and 49 respectively
    onix_codes_from_list :country_codes, "CountryCode", :list => 91
    onix_code_from_list :territory, "Territory", :list => 49
    onix_code_from_list :country_excluded, "CountryExcluded", :list => 91
    onix_code_from_list :territory_excluded, "TerritoryExcluded", :list => 49

    onix_code_from_list :tax_rate_code_1, "TaxRateCode1", :list => 62
    onix_decimal_accessor :tax_rate_percent_1, "TaxRatePercent1"
    onix_decimal_accessor :taxable_amount_1, "TaxableAmount1"
    onix_decimal_accessor :tax_amount_1, "TaxAmount1"
    onix_code_from_list :tax_rate_code_2, "TaxRateCode2", :list => 62
    onix_decimal_accessor :tax_rate_percent_2, "TaxRatePercent2"
    onix_decimal_accessor :taxable_amount_2, "TaxableAmount2"
    onix_decimal_accessor :tax_amount_2, "TaxAmount2"
    onix_date_accessor :price_effective_from, "PriceEffectiveFrom"
    onix_date_accessor :price_effective_until, "PriceEffectiveUntil"
  end
end
