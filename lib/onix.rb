# coding: utf-8

require 'bigdecimal'
require 'cgi'
require 'singleton'
require 'roxml'

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

    def self.boolean
      lambda { |val| ""  if val }
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
  "elements/agent_identifier",
  "elements/conference_sponsor_identifier",
  "elements/copyright_owner_identifier",
  "elements/location_identifier",
  "elements/sales_outlet_identifier",
  "elements/supplier_identifier",
  "elements/text_item_identifier",

  # other element mappings
  "elements/name_base",
  "elements/name",
  "elements/person_date",
  "elements/professional_affiliation",
  "elements/product_form_feature",
  "elements/product_classification",
  "elements/audience",
  "elements/batch_bonus",
  "elements/complexity",
  "elements/copyright_owner",
  "elements/copyright_statement",
  "elements/discount_coded",
  "elements/main_subject",
  "elements/market_date",
  "elements/new_supplier",
  "elements/on_order_detail",
  "elements/page_run",
  "elements/prize",
  "elements/sales_outlet",
  "elements/stock_quantity_coded",
  "elements/text_item",
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
  "elements/reissue",
  "elements/supply_detail",
  "elements/market_representation",
  "elements/measure",
  "elements/bible",
  "elements/religious_text_feature",
  "elements/religious_text",
  "elements/content_item",
  "elements/product_base",
  "elements/contained_item",
  "elements/related_product",
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
