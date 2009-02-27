# coding: utf-8

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')

require 'onix'

context "ONIX::ProductIdentifier" do

  before(:each) do
    data_path = File.join(File.dirname(__FILE__),"..","data")
    file1    = File.join(data_path, "product_identifier.xml")
    @doc = LibXML::XML::Document.file(file1)
    @root = @doc.root
  end

  specify "should correctly convert to a string" do
    id = ONIX::ProductIdentifier.from_xml(@root.to_s)
    id.to_xml.to_s[0,19].should eql("<ProductIdentifier>")
  end

  specify "should provide read access to first level attibutes" do
    id = ONIX::ProductIdentifier.from_xml(@root.to_s)

    id.product_id_type.should eql(2)
    id.id_value.should eql("0858198363")
  end

  specify "should provide write access to first level attibutes" do
    id = ONIX::ProductIdentifier.new

    id.product_id_type = 2
    id.to_xml.to_s.include?("<ProductIDType>02</ProductIDType>").should be_true

    id.id_value = "James"
    id.to_xml.to_s.include?("<IDValue>James</IDValue>").should be_true

  end

end

