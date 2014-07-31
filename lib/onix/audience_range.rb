# coding: utf-8

module ONIX
  class AudienceRange
    include Virtus.model

    attribute :audience_range_qualifier, Integer
    attribute :audience_range_precisions, Array[Integer]
    attribute :audience_range_values, Array[Integer]

    # TODO: element AudienceRange: validity error :
    #   Element AudienceRange content does not follow the DTD, expecting
    #   (AudienceRangeQualifier , AudienceRangePrecision , AudienceRangeValue ,
    #   (AudienceRangePrecision , AudienceRangeValue)?),
    #   got
    #   (AudienceRangeQualifier AudienceRangePrecision AudienceRangePrecision
    #   AudienceRangeValue AudienceRangeValue )

    def to_xml
      AudienceRangeRepresenter.new(self).to_xml
    end

    def self.from_xml(data)
      AudienceRangeRepresenter.new(self.new).from_xml(data)
    end
  end

  class AudienceRangeRepresenter < Representable::Decorator
    include Representable::XML

    self.representation_wrap = :AudienceRange

    property :audience_range_qualifier, as: "AudienceRangeQualifier", render_filter: ::ONIX::Formatters::TWO_DIGITS
    collection :audience_range_precisions, as: "AudienceRangePrecision", render_filter: ::ONIX::Formatters::TWO_DIGITS
    collection :audience_range_values, as: "AudienceRangeValue", render_filter: ::ONIX::Formatters::TWO_DIGITS
  end
end
