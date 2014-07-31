# coding: utf-8

module ONIX
  class SalesRestriction
    include Virtus.model

    attribute :sales_restriction_type, Integer

    def to_xml
      SalesRestrictionRepresenter.new(self).to_xml
    end

    def self.from_xml(data)
      SalesRestrictionRepresenter.new(self.new).from_xml(data)
    end
  end

  class SalesRestrictionRepresenter < Representable::Decorator
    include Representable::XML

    self.representation_wrap = :SalesRestriction

    property :sales_restriction_type, as: "SalesRestrictionType", render_filter: ::ONIX::Formatters::TWO_DIGITS
  end
end
