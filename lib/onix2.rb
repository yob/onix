# coding: utf-8

require 'active_support'
require 'bigdecimal'
require 'cgi'
require 'singleton'
require 'representable/xml'
require 'virtus'

module ONIX2
  class Formatters

    TWO_DIGITS = ->(value, *context) {
      if value.is_a?(Array)
        value.each_with_index do |val, index|
          value[index] = ONIX2::Formatters::two_digits_format(val)
        end
      else
        ONIX2::Formatters::two_digits_format(value)
      end
    }

    def self.two_digits_format(value)
      if value.nil?
          nil
        elsif value.to_i < 10
          "%02i" % value
        elsif value.to_i > 99
          value.to_s[-2,2]
        else
          value.to_s
        end
    end

    YYYYMMDD = ->(value, *context) { value.strftime("%Y%m%d") if value.respond_to? :strftime }
    DECIMAL = ->(value, *context) {
      case value
      when nil then nil
      when BigDecimal then value.to_s("F")
      else value.to_s
      end
    }

  end

  # core files
  # - ordering is important, classes need to be defined before any
  #   other class can use them
  autoload :SenderIdentifier, "onix2/sender_identifier"
  autoload :AddresseeIdentifier, "onix2/addressee_identifier"
  autoload :Header, "onix2/header"
  autoload :ProductIdentifier, "onix2/product_identifier"
  autoload :SeriesIdentifier, "onix2/series_identifier"
  autoload :Series, "onix2/series"
  autoload :Title, "onix2/title"
  autoload :Website, "onix2/website"
  autoload :Contributor, "onix2/contributor"
  autoload :Language, "onix2/language"
  autoload :Subject, "onix2/subject"
  autoload :AudienceRange, "onix2/audience_range"
  autoload :Imprint, "onix2/imprint"
  autoload :Publisher, "onix2/publisher"
  autoload :OtherText, "onix2/other_text"
  autoload :MediaFile, "onix2/media_file"
  autoload :SalesRestriction, "onix2/sales_restriction"
  autoload :Stock, "onix2/stock"
  autoload :DiscountCoded, "onix2/discount_coded"
  autoload :Price, "onix2/price"
  autoload :SupplyDetail, "onix2/supply_detail"
  autoload :MarketRepresentation, "onix2/market_representation"
  autoload :Measure, "onix2/measure"
  autoload :Product, "onix2/product"
  autoload :Reader, "onix2/reader"
  autoload :Writer, "onix2/writer"
  autoload :SalesRight, "onix2/sales_right"

  # product wrappers
  autoload :SimpleProduct, "onix2/simple_product"
  autoload :APAProduct, "onix2/apa_product"

  # misc
  autoload :Lists, "onix2/lists"
  autoload :CodeListExtractor, "onix2/code_list_extractor"

end
