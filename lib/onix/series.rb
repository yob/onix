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

  end
end
