# coding: utf-8

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')

require 'onix'

context "ONIX::Subject" do

  before(:each) do
    data_path = File.join(File.dirname(__FILE__),"..","data")
    file1    = File.join(data_path, "subject.xml")
    @doc = LibXML::XML::Document.file(file1)
    @root = @doc.root
  end

  specify "should correctly convert to a string" do
    sub = ONIX::Subject.from_xml(@root.to_s)
    sub.to_xml.to_s[0,9].should eql("<Subject>")
  end

  specify "should provide read access to first level attibutes" do
    sub = ONIX::Subject.from_xml(@root.to_s)
    sub.subject_scheme_id.should eql(3)
    sub.subject_scheme_name.should eql("RBA Subjects")
    sub.subject_code.should eql("AABB")
  end

  specify "should provide write access to first level attibutes" do
    sub = ONIX::Subject.new

    sub.subject_scheme_id = 2
    sub.to_xml.to_s.include?("<SubjectSchemeIdentifier>02</SubjectSchemeIdentifier>").should be_true

    sub.subject_code = "ABCD"
    sub.to_xml.to_s.include?("<SubjectCode>ABCD</SubjectCode>").should be_true

  end

end

