# coding: utf-8
# milkfarm
module ONIX
  class SeriesIdentifier
    include ROXML
    include ONIX::Common

    xml_name "SeriesIdentifier"

    xml_accessor :series_id_type, :from => "SeriesIDType", :as => Fixnum, :to_xml => ONIX::Formatters.two_digit
    xml_accessor :id_value, :from => "IDValue"
  end
end
