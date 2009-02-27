# coding: utf-8

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')

require 'onix'

context "ONIX::Title" do

  before(:each) do
    data_path = File.join(File.dirname(__FILE__),"..","data")
    file1    = File.join(data_path, "title.xml")
    @doc = LibXML::XML::Document.file(file1)
    @root = @doc.root
  end

  specify "should correctly convert to a string" do
    t = ONIX::Title.from_xml(@root.to_s)
    t.to_xml.to_s[0,7].should eql("<Title>")
  end

  specify "should provide read access to first level attibutes" do
    t = ONIX::Title.from_xml(@root.to_s)
    t.title_type.should eql(1)
    t.title_text.should eql("Good Grief")
    t.subtitle.should   eql("A Constructive Approach to the Problem of Loss")
  end

  specify "should provide write access to first level attibutes" do
    t = ONIX::Title.new

    t.title_type = 1
    t.to_xml.to_s.include?("<TitleType>01</TitleType>").should be_true

    t.title_text = "Good Grief"
    t.to_xml.to_s.include?("<TitleText>Good Grief</TitleText>").should be_true

    t.subtitle = "Blah"
    t.to_xml.to_s.include?("<Subtitle>Blah</Subtitle>").should be_true

  end

end

