# coding: utf-8

module ONIX2
  class SeriesIdentifier
  include Virtus.model

    attribute :series_id_type, Integer
    attribute :id_value

    def to_xml
      SeriesIdentifierRepresenter.new(self).to_xml
    end

    def self.from_xml(data)
      SeriesIdentifierRepresenter.new(self.new).from_xml(data)
    end
  end

  class SeriesIdentifierRepresenter < Representable::Decorator
    include Representable::XML

    self.representation_wrap = :SeriesIdentifier

    property :series_id_type, as: "SeriesIDType", render_filter: ::ONIX2::Formatters::TWO_DIGITS
    property :id_value, as: "IDValue"
  end
end
