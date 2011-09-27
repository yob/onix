# coding: utf-8

class ONIX::AudienceRange < ONIX::Element
  xml_name "AudienceRange"
  onix_code_from_list :audience_range_qualifier, "AudienceRangeQualifier", :list => 30
  onix_codes_from_list :audience_range_precision, "AudienceRangePrecision", :list => 31
  xml_accessor :audience_range_values, :from => "AudienceRangeValue", :as => [Fixnum]

  # TODO: element AudienceRange: validity error :
  #   Element AudienceRange content does not follow the DTD, expecting
  #   (AudienceRangeQualifier , AudienceRangePrecision , AudienceRangeValue ,
  #   (AudienceRangePrecision , AudienceRangeValue)?),
  #   got
  #   (AudienceRangeQualifier AudienceRangePrecision AudienceRangePrecision
  #   AudienceRangeValue AudienceRangeValue )
  def initialize
    self.audience_range_precisions = []
    self.audience_range_values = []
  end
end
