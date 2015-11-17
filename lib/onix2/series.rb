# coding: utf-8

module ONIX2
  class Series
    include Virtus.model

    attribute :series_identifiers, Array[ONIX2::SeriesIdentifier]
    attribute :title_of_series

    def to_xml
      SeriesRepresenter.new(self).to_xml
    end

    def self.from_xml(data)
      SeriesRepresenter.new(self.new).from_xml(data)
    end

  end

  class SeriesRepresenter < Representable::Decorator
    include Representable::XML

    self.representation_wrap = :Series

    collection :series_identifiers, as: "SeriesIdentifier", extend: ONIX2::SeriesIdentifierRepresenter, class: ONIX2::SeriesIdentifier
    property :title_of_series, as: "TitleOfSeries"
  end
end
