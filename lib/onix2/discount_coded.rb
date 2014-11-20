# coding: utf-8

module ONIX2
  class DiscountCoded
    include Virtus.model

    attribute :discount_code_type, Integer
    attribute :discount_code_type_name
    attribute :discount_code

    def to_xml
      DiscountCodedRepresenter.new(self).to_xml
    end

    def self.from_xml(data)
      DiscountCodedRepresenter.new(self.new).from_xml(data)
    end
  end

  class DiscountCodedRepresenter < Representable::Decorator
    include Representable::XML

    self.representation_wrap = :DiscountCoded

    property :discount_code_type, as: "DiscountCodeType", render_filter: ::ONIX2::Formatters::TWO_DIGITS
    property :discount_code_type_name, as: "DiscountCodeTypeName"
    property :discount_code, as: "DiscountCode"
  end
end
