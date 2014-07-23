# coding: utf-8

require 'spec_helper'

describe ONIX::Contributor do

  Given(:doc) { load_xml "contributor.xml" }

  describe "should correctly convert to a string" do
    Given(:header) { ONIX::Contributor.from_xml(doc) }
    Then { header.to_xml.to_s.start_with? "<Contributor>" }
  end

  describe "should provide read access to first level attributes" do
    Given(:contrib) { ONIX::Contributor.from_xml(doc) }

    Then { contrib.contributor_role == "A01" }
    Then { contrib.person_name_inverted == "SHAPIRO" }
    Then { contrib.sequence_number == 1 }
  end

  context "should provide write access to first level attributes" do
    Given(:contrib) { ONIX::Contributor.new }
    describe :contributor_role= do
      When { contrib.contributor_role = "A02" }
      Then { contrib.to_xml.to_s.include? "<ContributorRole>A02</ContributorRole>" }
    end
    describe :person_name_inverted= do
      When { contrib.person_name_inverted = "Healy, James" }
      Then { contrib.to_xml.to_s.include? "<PersonNameInverted>Healy, James</PersonNameInverted>" }
    end
    describe :sequence_number= do
      When { contrib.sequence_number = 1 }
      Then { contrib.to_xml.to_s.include? "<SequenceNumber>1</SequenceNumber>" }
    end
  end

end
