# coding: utf-8

require File.dirname(__FILE__) + '/spec_helper.rb'

describe ONIX::Product do

  before(:each) do
    @data_path = File.join(File.dirname(__FILE__),"..","data")
    file1    = File.join(@data_path, "product_google_sample_onix_2.1.xml")
    @doc     = Nokogiri::XML::Document.parse(File.read(file1))
    @product_node = @doc.root
  end

  it "should provide read access to product IDs" do
    product = ONIX::Product.from_xml(@product_node.to_s)
    product.epub_type.should eql( "029")
  end

end
