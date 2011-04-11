# coding: utf-8

module ONIX
  class SeriesIdentifier
    include ROXML

    xml_name "SeriesIdentifier"

    xml_accessor :series_id_type, :from => "SeriesIDType", :as => Fixnum, :to_xml => ONIX::Formatters.two_digit
    xml_accessor :id_value, :from => "IDValue"
  end
end
