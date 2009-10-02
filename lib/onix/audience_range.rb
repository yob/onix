# coding: utf-8

module ONIX
  class AudienceRange
    include ROXML
    include ONIX::Common

    xml_name "AudienceRange"

    xml_accessor :audience_range_qualifier, :from => "AudienceRangeQualifier", :as => Fixnum, :to_xml => ONIX::Formatters.two_digit
    xml_accessor :audience_range_precisions, :from => "AudienceRangePrecision", :as => [Fixnum], :to_xml => [ONIX::Formatters.two_digit] # TODO: two_digit isn't working on the array items
    xml_accessor :audience_range_values, :from => "AudienceRangeValue", :as => [Integer]

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
end
