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

  VERSION = ONIX::Version::String

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
        elsif val < 10
          "0#{val}"
        elsif val > 99
          val.to_s[-2,2]
        else
          val.to_s
        end
      end
    end

    def self.space_separated
      lambda { |val| val.join(" ")  if val }
    end
  end
end


# Ordering is important here; classes need to be defined before any
# other class can use them.
[
  # core files
  "core/element",
  "core/lists",
  "core/code",

  # identifier mappings
  "elements/identifier",
  "elements/sender_identifier",
  "elements/addressee_identifier",
  "elements/person_name_identifier",
  "elements/product_identifier",
  "elements/series_identifier",
  "elements/work_identifier",
  "elements/conference_sponsor_identifier",

  # other element mappings
  "elements/name",
  "elements/person_date",
  "elements/professional_affiliation",
  "elements/product_form_feature",
  "elements/product_classification",
  "elements/title",
  "elements/website",
  "elements/contributor",
  "elements/series",
  "elements/set",
  "elements/conference_sponsor",
  "elements/conference",
  "elements/extent",
  "elements/illustrations",
  "elements/language",
  "elements/subject",
  "elements/audience_range",
  "elements/imprint",
  "elements/publisher",
  "elements/other_text",
  "elements/media_file",
  "elements/sales_restriction",
  "elements/sales_rights",
  "elements/not_for_sale",
  "elements/stock",
  "elements/price",
  "elements/supply_detail",
  "elements/market_representation",
  "elements/measure",
  "elements/product",

  # more core files
  "core/header",
  "core/reader",
  "core/writer",

  # product wrappers
  "wrappers/simple_product",
  "wrappers/apa_product",

  # utilities
  "utils/normaliser",
  "utils/code_list_extractor"
].each do |req|
  require File.join("onix", req)
end
