# coding: utf-8

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')

require 'onix'
require 'date'

context "ONIX::SLProduct" do

  before(:each) do
    @data_path = File.join(File.dirname(__FILE__),"..","data")
    file1 = File.join(@data_path, "sl_product.xml")
    @doc = LibXML::XML::Document.file(file1)
    @product_node = @doc.root
  end

  specify "should provide read access to attibrutes" do
    @product = ONIX::Product.from_xml(@product_node.to_s)
    @sl = ONIX::SLProduct.new(@product)

    @sl.record_reference.should eql("10001")
    @sl.notification_type.should eql(2)
    @sl.number_of_pages.should eql(32)
    @sl.publishing_status.should eql(2)
    @sl.publication_date.should eql(Date.civil(2009,12,1))
    @sl.copyright_year.should eql(2008)
  end

  specify "should provide write access to attibutes" do
    apa = ONIX::SLProduct.new

    apa.notification_type = 3
    apa.to_xml.to_s.include?("<NotificationType>03</NotificationType>").should be_true

    apa.record_reference = "999"
    apa.to_xml.to_s.include?("<RecordReference>999</RecordReference>").should be_true

    apa.number_of_pages = 100
    apa.to_xml.to_s.include?("<NumberOfPages>100</NumberOfPages>").should be_true

    apa.publishing_status = 4
    apa.to_xml.to_s.include?("<PublishingStatus>04</PublishingStatus>").should be_true

    apa.publication_date = Date.civil(1998,9,1)
    apa.to_xml.to_s.include?("<PublicationDate>19980901</PublicationDate>").should be_true
  end

end
