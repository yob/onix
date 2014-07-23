# coding: utf-8

require 'spec_helper'

describe ONIX::AudienceRange do

  Given(:doc) { load_xml "audience_range.xml" }

  describe "should correctly convert to a string" do
    Given(:aud) { ONIX::AudienceRange.from_xml(doc) }
    Then { aud.to_xml.to_s.start_with? "<AudienceRange>" }
  end

  describe "should provide read access to first level attributes" do
    Given(:aud) { ONIX::AudienceRange.from_xml(doc) }

    Then { aud.audience_range_qualifier == 11 }
    Then { aud.audience_range_precisions.size == 2 }
    Then { aud.audience_range_precisions[0] == 3 }
    Then { aud.audience_range_precisions[1] == 4 }
    Then { aud.audience_range_values.size == 2 }
    Then { aud.audience_range_values[0] == 3 }
    Then { aud.audience_range_values[1] == 5 }
  end

  context "should provide write access to first level attributes" do
    Given(:aud) { ONIX::AudienceRange.new }
    describe :audience_range_qualifier= do
      When { aud.audience_range_qualifier = 12 }
      Then { aud.to_xml.to_s.include? "<AudienceRangeQualifier>12</AudienceRangeQualifier>" }
    end
    describe :audience_range_precisions= do
      When { aud.audience_range_precisions[0] = 888 }
      Then { aud.to_xml.to_s.include? "<AudienceRangePrecision>888</AudienceRangePrecision>" }
    end
    describe :audience_range_values= do
      When { aud.audience_range_values[0] = 999 }
      Then { aud.to_xml.to_s.include? "<AudienceRangeValue>999</AudienceRangeValue>" }
    end
  end

end
