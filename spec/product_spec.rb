# coding: utf-8

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')

require 'onix'
require 'date'

context "ONIX::Product" do

  before(:each) do
    @data_path = File.join(File.dirname(__FILE__),"..","data")
    file1    = File.join(@data_path, "product.xml")
    @doc = LibXML::XML::Document.file(file1)
    @product_node = @doc.root
  end

  specify "should provide read access to first level attibutes" do
    product = ONIX::Product.from_xml(@product_node.to_s)

    product.record_reference.should eql("365-9780194351898")
    product.notification_type.should eql(3)
    product.product_form.should eql("BC")
    product.edition_number.should eql(1)
    product.number_of_pages.should eql(100)
    product.bic_main_subject.should eql("EB")
    product.publishing_status.should eql(4)
    product.publication_date.should eql(Date.civil(1998,9,1))
    product.year_first_published.should eql(1998)

    # including ye olde, deprecated ones
    product.height.should eql(100)
    product.width.should eql(BigDecimal.new("200.5"))
    product.weight.should eql(300)
    product.thickness.should eql(300)
    product.dimensions.should eql("100x200")
  end

  specify "should provide read access to product IDs" do
    product = ONIX::Product.from_xml(@product_node.to_s)
    product.product_identifiers.size.should eql(3)
  end

  specify "should provide read access to titles" do
    product = ONIX::Product.from_xml(@product_node.to_s)
    product.titles.size.should eql(1)
  end

  specify "should provide read access to subjects" do
    product = ONIX::Product.from_xml(@product_node.to_s)
    product.subjects.size.should eql(1)
  end

  specify "should provide read access to measurements" do
    product = ONIX::Product.from_xml(@product_node.to_s)
    product.measurements.size.should eql(1)
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

    product.year_first_published = 1998
    product.year_first_published.should eql(1998)
  end

  specify "should correctly from_xml files that have non-standard entties"
=begin
  do
    file = File.join(@data_path, "extra_entities.xml")
    product = ONIX::Product.from_xml(File.read(file))

    product.titles.first.title_text.should eql("Ipod® & Itunes® for Dummies®, 4th Edition")
  end
=end
end
