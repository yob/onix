# coding: utf-8

module ONIX
  class Series
    include ROXML
    include ONIX::Common

    xml_name "Series"

    xml_accessor :series_identifiers, :from => "SeriesIdentifier", :as => [ONIX::SeriesIdentifier]
    xml_accessor :title_of_series, :from => "TitleOfSeries"

    def initialize
      self.series_identifiers = []
    end

    # retrieve the proprietary series ID
    def proprietary_series_id
      series_identifier(1).andand.id_value
    end

    # set a new proprietary series ID
    def proprietary_series_id=(id)
      series_identifier_set(1, id)
    end

    # retrieve the issn
    def issn
      series_identifier(2).andand.id_value
    end

    # set a new issn
    def issn=(id)
      series_identifier_set(2, id)
    end

    # retrieve the value of a particular ID
    def series_identifier(type)
      identifier = series_identifiers.find { |id| id.series_id_type == type }
    end

    # set the value of a particular ID
    def series_identifier_set(type, value)
      series_indentifier_id = series_identifiers.find { |id| id.series_id_type == type }

      # create a new series identifier record if we need to
      if series_indentifier_id.nil?
        series_indentifier_id = ONIX::SeriesIdentifier.new
      end

      series_indentifier_id.series_id_type = type
      series_indentifier_id.id_value = value

      series_identifiers << series_indentifier_id
    end
  end
end
