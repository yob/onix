# coding: utf-8

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')

require 'onix'

context "ONIX::Reader" do

  before(:each) do
    data_path = File.join(File.dirname(__FILE__),"..","data")
    @file1    = File.join(data_path, "9780194351898.xml")
    @file2    = File.join(data_path, "two_products.xml")
  end

  specify "should initialize with a filename" do
    reader = ONIX::Reader.new(@file1)
    reader.instance_variable_get("@reader").should be_a_kind_of(XML::Reader)
  end

  specify "should initialize with an IO object" do
    File.open(@file1,"rb") do |f|
      reader = ONIX::Reader.new(f)
      reader.instance_variable_get("@reader").should be_a_kind_of(XML::Reader)
    end
  end

  specify "should provide access to various XML metadata from file" do
    reader = ONIX::Reader.new(@file1)
    reader.encoding.should eql("utf-8")
    reader.xml_lang.should eql(nil)
    reader.xml_version.should eql(1.0)
    reader.version.should eql([2,1,0])
  end

  specify "should provide access to the header in an ONIX file" do
    reader = ONIX::Reader.new(@file1)
    reader.header.should be_a_kind_of(ONIX::Header)
  end

  specify "should iterate over all product records in an ONIX file" do
    reader = ONIX::Reader.new(@file1)
    counter = 0
    reader.each do |product|
      product.should be_a_kind_of(ONIX::Product)
      counter += 1
    end

    counter.should eql(1)
  end

  specify "should iterate over all product records in an ONIX file" do
    reader = ONIX::Reader.new(@file2)
    products = []
    reader.each do |product|
      products << product
    end

    products.size.should eql(2)
    products[0].id(:ean).should eql("9780194351898")
    products[1].id(:ean).should eql("9780754672326")
  end
end
