# coding: utf-8
# milkfarm
module ONIX
  class Series
    include ROXML
    include ONIX::Common

    xml_name "Series"

    xml_accessor :title_of_series, :from => "TitleOfSeries"
  end
end
