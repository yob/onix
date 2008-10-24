# coding: utf-8

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')

require 'onix'
require 'date'

context "ONIX::Product" do

  before(:each) do
    data_path = File.join(File.dirname(__FILE__),"..","data")
    file1    = File.join(data_path, "product.xml")
    @doc = XML::Document.file(file1)
    @product_node = @doc.root
  end

  specify "should initialise with an existing node" do
    product = ONIX::Product.new(@product_node)
    product.instance_variable_get("@root_node").should eql(@product_node)
  end

  specify "should create an empty node if none is provided on init" do
    product = ONIX::Product.new
    product.instance_variable_get("@root_node").should be_a_kind_of(XML::Node)
  end

  specify "should provide read access to first level attibutes" do
    product = ONIX::Product.new(@product_node)

    product.record_reference.should eql("365-9780194351898")
    product.notification_type.should eql(3)
    product.product_form.should eql("BC")
    product.edition_number.should eql(1)
    product.number_of_pages.should eql(100)
    product.bic_main_subject.should eql("EB")
    product.publishing_status.should eql(4)
    product.publication_date.should eql(Date.civil(1998,9,1))
    product.year_first_published.should eql("1998")
  end

  specify "should provide read access to product IDs" do
    product = ONIX::Product.new(@product_node)

    product.id(:isbn10).should eql("0194351890")
    product.id(:isbn13).should eql("9780194351898")
    product.id(:ean).should    eql("9780194351898")
  end

  specify "should provide read access to titles" do
    product = ONIX::Product.new(@product_node)

    product.title(:distinct).should eql("OXFORD PICTURE DICTIONARY CHINESE")
  end

  specify "should provide read access to subjects" do
    product = ONIX::Product.new(@product_node)

    product.subjects(:bic_lang).should eql(['2ABM'])
  end

  specify "should provide write access to first level attibutes" do
    product = ONIX::Product.new

    product.notification_type = 3
    product.notification_type.should eql(3)
    product.record_reference = "365-9780194351898"
    product.record_reference.should eql("365-9780194351898")

    product.product_form = "BC"
    product.product_form.should eql("BC")

    product.edition_number = 1
    product.edition_number.should eql(1)

    product.number_of_pages = 100
    product.number_of_pages.should eql(100)

    product.bic_main_subject = "EB"
    product.bic_main_subject.should eql("EB")

    product.publishing_status = 4
    product.publishing_status.should eql(4)

    product.publication_date = Date.civil(1998,9,1)
    product.publication_date.should eql(Date.civil(1998,9,1))

    product.year_first_published = "1998"
    product.year_first_published.should eql("1998")
  end

  specify "should provide write access to product IDs" do
    product = ONIX::Product.new

    product.set_id("0194351890", :isbn10)
    product.id(:isbn10).should eql("0194351890")
    #product.id(:isbn13).should eql("9780194351898")
    #product.id(:ean).should    eql("9780194351898")
  end
end
