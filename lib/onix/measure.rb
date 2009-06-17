# coding: utf-8

module ONIX
  class Measure
    include ROXML
    include ONIX::Common

    xml_name "Measure"

    xml_accessor :measure_type_code, :from => "MeasureTypeCode", :as => Fixnum, :to_xml => ONIX::Formatters.two_digit
    xml_accessor :measurement,       :from => "Measurement", :as => BigDecimal
    xml_accessor :measure_unit_code, :from => "MeasureUnitCode"
  end
end
