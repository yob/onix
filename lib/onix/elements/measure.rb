# coding: utf-8

class ONIX::Measure < ONIX::Element
  xml_name "Measure"
  onix_code_from_list :measure_type_code, "MeasureTypeCode", :list => 48
  xml_accessor :measurement, :from => "Measurement", :as => BigDecimal
  xml_accessor :measure_unit_code, :from => "MeasureUnitCode"
end
