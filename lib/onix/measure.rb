module ONIX
  class Measure
    include ROXML

    xml_accessor :measure_type_code, :from => "MeasureTypeCode", :as => Fixnum # should be a 2 digit num
    xml_accessor :measurement,       :from => "Measurement", :as => Float
    xml_accessor :measure_unit_code, :from => "MeasureUnitCode"
  end
end
