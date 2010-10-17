# coding: utf-8

require File.dirname(__FILE__) + '/spec_helper.rb'

context "ONIX::Contributor" do

  before(:each) do
    data_path = File.join(File.dirname(__FILE__),"..","data")
    file1    = File.join(data_path, "contributor.xml")
    @doc = Nokogiri::XML::Document.parse(File.read(file1))
    @root = @doc.root
  end

  specify "should correctly convert to a string" do
    header = ONIX::Contributor.from_xml(@root.to_s)
    header.to_xml.to_s[0,13].should eql("<Contributor>")
  end

  specify "should provide read access to first level attributes" do
    contrib = ONIX::Contributor.from_xml(@root.to_s)

    contrib.contributor_role.should eql("A01")
    contrib.person_name_inverted.should eql("SHAPIRO")
    contrib.sequence_number.should eql(1)
  end

  specify "should provide write access to first level attributes" do
    contrib = ONIX::Contributor.new

    contrib.contributor_role = "A02"
    contrib.to_xml.to_s.include?("<ContributorRole>A02</ContributorRole>").should be_true

    contrib.person_name_inverted = "Healy, James"
    contrib.to_xml.to_s.include?("<PersonNameInverted>Healy, James</PersonNameInverted>").should be_true

    contrib.sequence_number = 1
    contrib.to_xml.to_s.include?("<SequenceNumber>1</SequenceNumber>").should be_true
  end

end
