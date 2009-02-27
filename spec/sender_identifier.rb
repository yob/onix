# coding: utf-8

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')

require 'onix'

context "ONIX::SenderIdentifier" do

  before(:each) do
    data_path = File.join(File.dirname(__FILE__),"..","data")
    file1    = File.join(data_path, "sender_identifier.xml")
    @doc = LibXML::XML::Document.file(file1)
    @root = @doc.root
  end

  specify "should correctly convert to a string" do
    id = ONIX::SenderIdentifier.from_xml(@root.to_s)
    id.to_xml.to_s[0,18].should eql("<SenderIdentifier>")
  end

  specify "should provide read access to first level attibutes" do
    id = ONIX::SenderIdentifier.from_xml(@root.to_s)

    id.sender_id_type.should eql(1)
    id.id_value.should eql("123456")
  end

  specify "should provide write access to first level attibutes" do
    id = ONIX::SenderIdentifier.new

    id.sender_id_type = 1
    id.to_xml.to_s.include?("<SenderIDType>01</SenderIDType>").should be_true

    id.id_value = "54321"
    id.to_xml.to_s.include?("<IDValue>54321</IDValue>").should be_true

  end

end

