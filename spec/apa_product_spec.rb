# coding: utf-8

require 'spec_helper'

describe "ONIX2::APAProduct" do

  Given(:doc) { load_xml "product.xml" }

  describe "should provide read access to attributes" do
    Given(:product) { ONIX2::Product.from_xml(doc) }
    Given(:apa) { ONIX2::APAProduct.new(product) }

    Then { apa.record_reference == "365-9780194351898" }
    Then { apa.notification_type == 3 }
    Then { apa.product_form == "BC" }
    Then { apa.number_of_pages == 100 }
    Then { apa.bic_main_subject == "EB" }
    Then { apa.publishing_status == 4 }
    Then { apa.publication_date == Date.civil(1998,9,1) }
    Then { apa.pack_quantity == 12 }
  end

  context "should provide write access to attributes" do
    Given(:apa) { ONIX2::APAProduct.new }
    describe :notification_type= do
      When { apa.notification_type = 3 }
      Then { apa.to_xml.to_s.include? "<NotificationType>03</NotificationType>" }
    end
    describe :record_reference= do
      When { apa.record_reference = "365-9780194351898" }
      Then { apa.to_xml.to_s.include? "<RecordReference>365-9780194351898</RecordReference>" }
    end
    describe :product_form= do
      When { apa.product_form = "BC" }
      Then { apa.to_xml.to_s.include? "<ProductForm>BC</ProductForm>" }
    end
    describe :number_of_pages= do
      When { apa.number_of_pages = 100 }
      Then { apa.to_xml.to_s.include? "<NumberOfPages>100</NumberOfPages>" }
    end
    describe :bic_main_subject= do
      When { apa.bic_main_subject = "EB" }
      Then { apa.to_xml.to_s.include? "<BICMainSubject>EB</BICMainSubject>" }
    end
    describe :publishing_status= do
      When { apa.publishing_status = 4 }
      Then { apa.to_xml.to_s.include? "<PublishingStatus>04</PublishingStatus>" }
    end
    describe :publication_date= do
      When { apa.publication_date = Date.civil(1998,9,1) }
      Then { apa.to_xml.to_s.include? "<PublicationDate>19980901</PublicationDate>" }
    end
    describe :pack_quantity= do
      When { apa.pack_quantity = 12 }
      Then { apa.to_xml.to_s.include? "<PackQuantity>12</PackQuantity>" }
    end
  end

end

describe ONIX2::APAProduct, "series method" do
  describe "should set the nested series value on the underlying product class" do
    Given(:apa) { ONIX2::APAProduct.new }

    When { apa.series = "Harry Potter" }
    Then { apa.series == "Harry Potter" }
    Then { apa.to_xml.to_s.include? "<TitleOfSeries>Harry Potter</TitleOfSeries>" }
  end
end

describe ONIX2::APAProduct, "price method" do
  Given(:doc) { load_xml "usd.xml" }

  describe "should return the first price in the file, regardless of type" do
    Given(:product) { ONIX2::Product.from_xml(doc) }
    Given(:apa) { ONIX2::APAProduct.new(product) }

    Then { apa.price == BigDecimal.new("99.95") }
  end
end

describe ONIX2::APAProduct, "rrp_exc_sales_tax method" do
  Given(:doc) { load_xml "usd.xml" }

  describe "should return the first price in the file of type 1" do
    Given(:product) { ONIX2::Product.from_xml(doc) }
    Given(:apa) { ONIX2::APAProduct.new(product) }

    Then { apa.rrp_exc_sales_tax == BigDecimal.new("99.95") }
  end
end

describe ONIX2::APAProduct, "proprietry_discount_code_for_rrp method" do
  Given(:doc) { load_xml "product.xml" }

  describe "should return the first price in the file, regardless of type" do
    Given(:product) { ONIX2::Product.from_xml(doc) }
    Given(:apa) { ONIX2::APAProduct.new(product) }

    Then { apa.proprietry_discount_code_for_rrp == "123" }
  end
end

describe ONIX2::APAProduct, "proprietry_discount_code_for_rrp= method" do
  Given(:doc) { load_xml "product.xml" }

  describe "should set the discount code on the RRP" do
    Given(:product) { ONIX2::Product.from_xml(doc) }
    Given(:apa) { ONIX2::APAProduct.new(product) }

    When { apa.proprietry_discount_code_for_rrp = "123" }
    Then { apa.to_xml.to_s.include? "<DiscountCode>123</DiscountCode>" }
  end
end
