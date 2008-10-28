module ONIX
  class Measure
    include ROXML

    xml_accessor :measure_type_code, :twodigit, :from => "MeasureTypeCode"
    xml_accessor :measurement,       :decimal,  :from => "Measurement"
    xml_accessor :measure_unit_code, :etext,    :from => "MeasureUnitCode"
  end
end
