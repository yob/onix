# coding: utf-8

require 'spec_helper.rb'

describe ONIX::Product do

  before(:each) do
    load_doc_and_root("product.xml")
    @product_node = @root
  end

  it "should provide read access to first level attributes" do
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

  it "should provide read access to product IDs" do
    product = ONIX::Product.from_xml(@product_node.to_s)
    product.product_identifiers.size.should eql(3)
  end

  it "should provide read access to titles" do
    product = ONIX::Product.from_xml(@product_node.to_s)
    product.titles.size.should eql(1)
  end

  it "should provide read access to subjects" do
    product = ONIX::Product.from_xml(@product_node.to_s)
    product.subjects.size.should eql(1)
  end

  it "should provide read access to measurements" do
    product = ONIX::Product.from_xml(@product_node.to_s)
    product.measurements.size.should eql(1)
  end

  it "should provide write access to first level attributes" do
    product = ONIX::Product.new

    product.notification_type = 3
    product.to_xml.to_s.include?("<NotificationType>03</NotificationType>").should be_true

    product.record_reference = "365-9780194351898"
    product.to_xml.to_s.include?("<RecordReference>365-9780194351898</RecordReference>").should be_true

    product.product_form = "BC"
    product.to_xml.to_s.include?("<ProductForm>BC</ProductForm>").should be_true

    product.edition_number = 1
    product.to_xml.to_s.include?("<EditionNumber>1</EditionNumber>").should be_true

    product.number_of_pages = 100
    product.to_xml.to_s.include?("<NumberOfPages>100</NumberOfPages>").should be_true

    product.bic_main_subject = "EB"
    product.to_xml.to_s.include?("<BICMainSubject>EB</BICMainSubject>").should be_true

    product.publishing_status = 4
    product.to_xml.to_s.include?("<PublishingStatus>04</PublishingStatus>").should be_true

    product.publication_date = Date.civil(1998,9,1)
    product.to_xml.to_s.include?("<PublicationDate>19980901</PublicationDate>").should be_true

    product.year_first_published = 1998
    product.to_xml.to_s.include?("<YearFirstPublished>1998</YearFirstPublished>").should be_true
  end

  it "should correctly from_xml files that have an invalid publication date" do
    file = find_data_file("product_invalid_pubdate.xml")
    product = ONIX::Product.from_xml(File.read(file))

    product.bic_main_subject.should eql("VXFC1")
    product.publication_date.should be_nil
  end


  it "should load an interpretation" do
    product = ONIX::Product.new
    product.interpret(ONIX::SpecInterpretations::Setters)
    product.title = "Grimm's Fairy Tales"
    product.titles.first.title_text.should eql("Grimm's Fairy Tales")
  end

  it "should load several interpretations" do
    product = ONIX::Product.new
    product.interpret([
      ONIX::SpecInterpretations::Getters,
      ONIX::SpecInterpretations::Setters
    ])
    product.title = "Grimm's Fairy Tales"
    product.title.should eql("grimm's fairy tales")
  end

  it "should pass on interpretations to other products" do
    product1 = ONIX::Product.new
    product1.interpret([
      ONIX::SpecInterpretations::Getters,
      ONIX::SpecInterpretations::Setters
    ])

    product2 = ONIX::Product.new
    product1.interpret_like_me(product2)
    product2.title = "Grimm's Fairy Tales"
    product2.title.should eql("grimm's fairy tales")
  end

end
