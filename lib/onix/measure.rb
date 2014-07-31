# coding: utf-8

module ONIX
  class Measure
    include Virtus.model

    attribute :measure_type_code, Integer
    attribute :measurement #Integer or Decimal
    attribute :measure_unit_code

    def to_xml
      MeasureRepresenter.new(self).to_xml
    end

    def self.from_xml(data)
      MeasureRepresenter.new(self.new).from_xml(data)
    end
  end

  class MeasureRepresenter < Representable::Decorator
    include Representable::XML

    self.representation_wrap = :Measure

    property :measure_type_code, as: "MeasureTypeCode", render_filter: ::ONIX::Formatters::TWO_DIGITS
    property :measurement, as: "Measurement", render_filter: ::ONIX::Formatters::DECIMAL, parse_filter: ->(value, *context) { value.is_a?(Integer) ? value.to_i : BigDecimal.new(value) }
    property :measure_unit_code, as: "MeasureUnitCode"
  end
end
