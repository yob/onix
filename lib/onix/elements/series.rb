# coding: utf-8

class ONIX::Series < ONIX::Element
  xml_name "Series"
  onix_composite :series_identifiers, ONIX::SeriesIdentifier
  xml_accessor :title_of_series, :from => "TitleOfSeries"
  onix_composite :titles, ONIX::Title
  onix_composite :contributors, ONIX::Contributor
  xml_accessor :number_within_series, :from => "NumberWithinSeries"
  xml_accessor :year_of_annual, :from => "YearOfAnnual"
end
