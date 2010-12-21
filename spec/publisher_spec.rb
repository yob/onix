# coding: utf-8

require File.dirname(__FILE__) + '/spec_helper.rb'

describe ONIX::Publisher do

  before(:each) do
    data_path = File.join(File.dirname(__FILE__),"..","data")
    file1    = File.join(data_path, "publisher.xml")
    @doc     = Nokogiri::XML::Document.parse(File.read(file1))
    @root = @doc.root
  end

  it "should correctly convert to a string" do
    pub = ONIX::Publisher.from_xml(@root.to_s)
    pub.to_xml.to_s[0,11].should eql("<Publisher>")
  end

  it "should provide read access to first level attributes" do
    pub = ONIX::Publisher.from_xml(@root.to_s)
    pub.publishing_role.should eql(1)
    pub.publisher_name.should eql("Desbooks Publishing")
  end

  it "should provide write access to first level attributes" do
    pub = ONIX::Publisher.new

    pub.publisher_name = "Paulist Press"
    pub.to_xml.to_s.include?("<PublisherName>Paulist Press</PublisherName>").should be_true

    pub.publishing_role = 2
    pub.to_xml.to_s.include?("<PublishingRole>02</PublishingRole>").should be_true
  end

end

