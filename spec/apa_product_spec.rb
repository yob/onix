# coding: utf-8

require File.dirname(__FILE__) + '/spec_helper.rb'
require 'date'

describe "ONIX::APAProduct" do

  before(:each) do
    @data_path = File.join(File.dirname(__FILE__),"..","data")
    file1    = File.join(@data_path, "product.xml")
    @doc     = Nokogiri::XML::Document.parse(File.read(file1))
    @product_node = @doc.root
  end

  it "should provide read access to attributes" do
    @product = ONIX::Product.from_xml(@product_node.to_s)
    @apa     = ONIX::APAProduct.new(@product)

    @apa.record_reference.should eql("365-9780194351898")
    @apa.notification_type.should eql(3)
    @apa.product_form.should eql("BC")
    @apa.number_of_pages.should eql(100)
    @apa.bic_main_subject.should eql("EB")
    @apa.publishing_status.should eql(4)
    @apa.publication_date.should eql(Date.civil(1998,9,1))
    @apa.pack_quantity.should eql(12)
  end

  it "should provide write access to attributes" do
    apa = ONIX::APAProduct.new

    apa.notification_type = 3
    apa.to_xml.to_s.include?("<NotificationType>03</NotificationType>").should be_true

    apa.record_reference = "365-9780194351898"
    apa.to_xml.to_s.include?("<RecordReference>365-9780194351898</RecordReference>").should be_true

    apa.product_form = "BC"
    apa.to_xml.to_s.include?("<ProductForm>BC</ProductForm>").should be_true

    apa.number_of_pages = 100
    apa.to_xml.to_s.include?("<NumberOfPages>100</NumberOfPages>").should be_true

    apa.bic_main_subject = "EB"
    apa.to_xml.to_s.include?("<BICMainSubject>EB</BICMainSubject>").should be_true

    apa.publishing_status = 4
    apa.to_xml.to_s.include?("<PublishingStatus>04</PublishingStatus>").should be_true

    apa.publication_date = Date.civil(1998,9,1)
    apa.to_xml.to_s.include?("<PublicationDate>19980901</PublicationDate>").should be_true

    apa.pack_quantity = 12
    apa.to_xml.to_s.include?("<PackQuantity>12</PackQuantity>").should be_true
  end

end

describe ONIX::APAProduct, "series method" do
  it "should set the nested series value on the underlying product class" do
    apa = ONIX::APAProduct.new

    apa.series = "Harry Potter"
    apa.series.should eql("Harry Potter")
    apa.to_xml.to_s.include?("<TitleOfSeries>Harry Potter</TitleOfSeries>").should be_true
  end
end

describe ONIX::APAProduct, "price method" do
  before(:each) do
    @data_path = File.join(File.dirname(__FILE__),"..","data")
    file1    = File.join(@data_path, "usd.xml")
    @doc     = Nokogiri::XML::Document.parse(File.read(file1))
    @product_node = @doc.root
  end

  it "should return the first price in the file, regardless of type" do
    @product = ONIX::Product.from_xml(@product_node.to_s)
    @apa     = ONIX::APAProduct.new(@product)

    @apa.price.should eql(BigDecimal.new("99.95"))
  end
end

describe ONIX::APAProduct, "rrp_exc_sales_tax method" do
  before(:each) do
    @data_path = File.join(File.dirname(__FILE__),"..","data")
    file1    = File.join(@data_path, "usd.xml")
    @doc     = Nokogiri::XML::Document.parse(File.read(file1))
    @product_node = @doc.root
  end

  it "should return the first price in the file of type 1" do
    @product = ONIX::Product.from_xml(@product_node.to_s)
    @apa     = ONIX::APAProduct.new(@product)
    
    @apa.rrp_exc_sales_tax.should eql(BigDecimal.new("99.95"))
  end
  
  it "should return the first price in the file of type 1" do
    @apa     = ONIX::APAProduct.new
    @apa.rrp_exc_sales_tax_with_currency(2, "USD")
    @apa.to_xml.to_s.should eql ("<Product>
  <SupplyDetail>
    <Price>
      <PriceTypeCode>01</PriceTypeCode>
      <PriceAmount>2</PriceAmount>
      <CurrencyCode>USD</CurrencyCode>
    </Price>
  </SupplyDetail>
</Product>")
  end
  
end

describe ONIX::APAProduct, "proprietry_discount_code_for_rrp method" do
  before(:each) do
    @data_path = File.join(File.dirname(__FILE__),"..","data")
    file1    = File.join(@data_path, "product.xml")
    @doc     = Nokogiri::XML::Document.parse(File.read(file1))
    @product_node = @doc.root
  end

  it "should return the first price in the file, regardless of type" do
    @product = ONIX::Product.from_xml(@product_node.to_s)
    @apa     = ONIX::APAProduct.new(@product)

    @apa.proprietry_discount_code_for_rrp.should eql("123")
  end
end

describe ONIX::APAProduct, "proprietry_discount_code_for_rrp= method" do
  before(:each) do
    @data_path = File.join(File.dirname(__FILE__),"..","data")
    file1    = File.join(@data_path, "product.xml")
    @doc     = Nokogiri::XML::Document.parse(File.read(file1))
    @product_node = @doc.root
  end

  it "should set the discount code on the RRP" do
    @product = ONIX::Product.from_xml(@product_node.to_s)
    @apa     = ONIX::APAProduct.new(@product)

    @apa.proprietry_discount_code_for_rrp="123"
    @apa.to_xml.to_s.include?("<DiscountCode>123</DiscountCode>").should be_true
  end
end
