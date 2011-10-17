# coding: utf-8

require 'spec_helper.rb'

describe ONIX::Subject do

  before(:each) do
    load_doc_and_root("subject.xml")
  end

  it "should correctly convert to a string" do
    sub = ONIX::Subject.from_xml(@root.to_s)
    sub.to_xml.to_s[0,9].should eql("<Subject>")
  end

  it "should provide read access to first level attributes" do
    sub = ONIX::Subject.from_xml(@root.to_s)
    sub.subject_scheme_id.should eql(3)
    sub.subject_scheme_name.should eql("RBA Subjects")
    sub.subject_code.should eql("AABB")
  end

  it "should provide write access to first level attributes" do
    sub = ONIX::Subject.new

    sub.subject_scheme_id = 2
    sub.to_xml.to_s.include?("<SubjectSchemeIdentifier>02</SubjectSchemeIdentifier>").should be_true

    sub.subject_code = "ABCD"
    sub.to_xml.to_s.include?("<SubjectCode>ABCD</SubjectCode>").should be_true

  end

end
