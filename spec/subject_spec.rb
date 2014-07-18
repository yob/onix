# coding: utf-8

require File.dirname(__FILE__) + '/spec_helper.rb'

describe ONIX::Subject do

  Given(:doc) { File.read(File.join(File.dirname(__FILE__), "..", "data", "subject.xml")) }

  describe "should correctly convert to a string" do
    Given(:sub) { ONIX::Subject.from_xml(doc) }
    Then { sub.to_xml.to_s.start_with? "<Subject>" }
  end

  describe "should provide read access to first level attributes" do
    Given(:sub) { ONIX::Subject.from_xml(doc) }

    Then { sub.subject_scheme_id == 3 }
    Then { sub.subject_scheme_name == "RBA Subjects" }
    Then { sub.subject_code == "AABB" }
  end

  context "should provide write access to first level attributes" do
    Given(:sub) { ONIX::Subject.new }
    describe :subject_scheme_id= do
      When { sub.subject_scheme_id = 2 }
      Then { sub.to_xml.to_s.include? "<SubjectSchemeIdentifier>02</SubjectSchemeIdentifier>" }
    end
    describe :subject_code= do
      When { sub.subject_code = "ABCD" }
      Then { sub.to_xml.to_s.include? "<SubjectCode>ABCD</SubjectCode>" }
    end
  end

end
