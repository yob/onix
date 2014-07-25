# coding: utf-8

module ONIX
  class Series
    include Virtus.model

    attribute :series_identifiers, Array[ONIX::SeriesIdentifier]
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

    collection :series_identifiers, as: "SeriesIdentifier", extend: ONIX::SeriesIdentifierRepresenter, class: ONIX::SeriesIdentifier
    property :title_of_series, as: "TitleOfSeries"
  end
end
