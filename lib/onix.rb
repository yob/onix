# coding: utf-8

require 'bigdecimal'
require 'cgi'
require 'singleton'
require 'roxml'
require 'andand'

module ONIX
  module Version #:nodoc:
    Major = 0
    Minor = 9
    Tiny  = 0

    String = [Major, Minor, Tiny].join('.')
  end

  class Formatters
    def self.decimal
      lambda do |val|
        if val.nil?
          nil
        elsif val.kind_of?(BigDecimal)
          val.to_s("F")
        else
          val.to_s
        end
      end
    end

    def self.yyyymmdd
      lambda do |val|
        if val.nil? || !val.respond_to?(:strftime)
          nil
        else
          val.strftime("%Y%m%d")
        end
      end
    end

    def self.two_digit
      lambda do |val|
        if val.nil?
          nil
        elsif val.to_i < 10
          "0#{val}"
        elsif val.to_i > 99
          val.to_s[-2,2]
        else
          val.to_s
        end
      end
    end
  end

  # core files
  # - ordering is important, classes need to be defined before any
  #   other class can use them
  autoload :SenderIdentifier, "onix/sender_identifier"
  autoload :AddresseeIdentifier, "onix/addressee_identifier"
  autoload :Header, "onix/header"
  autoload :ProductIdentifier, "onix/product_identifier"
  autoload :SeriesIdentifier, "onix/series_identifier"
  autoload :Series, "onix/series"
  autoload :Title, "onix/title"
  autoload :Website, "onix/website"
  autoload :Contributor, "onix/contributor"
  autoload :Language, "onix/language"
  autoload :Subject, "onix/subject"
  autoload :AudienceRange, "onix/audience_range"
  autoload :Imprint, "onix/imprint"
  autoload :Publisher, "onix/publisher"
  autoload :OtherText, "onix/other_text"
  autoload :MediaFile, "onix/media_file"
  autoload :SalesRestriction, "onix/sales_restriction"
  autoload :Stock, "onix/stock"
  autoload :DiscountCoded, "onix/discount_coded"
  autoload :Price, "onix/price"
  autoload :SupplyDetail, "onix/supply_detail"
  autoload :MarketRepresentation, "onix/market_representation"
  autoload :Measure, "onix/measure"
  autoload :Product, "onix/product"
  autoload :Reader, "onix/reader"
  autoload :Writer, "onix/writer"

  # product wrappers
  autoload :SimpleProduct, "onix/simple_product"
  autoload :APAProduct, "onix/apa_product"

  # misc
  autoload :Lists, "onix/lists"
  autoload :Normaliser, "onix/normaliser"
  autoload :CodeListExtractor, "onix/code_list_extractor"

end
