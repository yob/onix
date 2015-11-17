# coding: utf-8

require 'spec_helper'

describe ONIX2::Product do

  Given(:doc) { load_xml "product.xml" }

  describe "should provide read access to first level attributes" do
    Given(:product) { ONIX2::Product.from_xml(doc) }

    Then { product.record_reference == "365-9780194351898" }
    Then { product.notification_type == 3 }
    Then { product.product_form == "BC" }
    Then { product.edition_number == 1 }
    Then { product.number_of_pages == 100 }
    Then { product.bic_main_subject == "EB" }
    Then { product.publishing_status == 4 }
    Then { product.publication_date == Date.civil(1998,9,1) }
    Then { product.year_first_published == 1998 }
    # including ye olde, deprecated ones
    Then { product.height == 100 }
    Then { product.width == BigDecimal.new("200.5") }
    Then { product.weight == 300 }
    Then { product.thickness == 300 }
    Then { product.dimensions == "100x200" }
    Then { product.epub_type == "029" }
  end

  describe "should provide read access to product IDs" do
    Given(:product) { ONIX2::Product.from_xml(doc) }
    Then { product.product_identifiers.size == 3 }
  end

  describe "should provide read access to titles" do
    Given(:product) { ONIX2::Product.from_xml(doc) }
    Then { product.titles.size == 1 }
  end

  describe "should provide read access to subjects" do
    Given(:product) { ONIX2::Product.from_xml(doc) }
    Then { product.subjects.size == 1 }
  end

  describe "should provide read access to measurements" do
    Given(:product) { ONIX2::Product.from_xml(doc) }
    Then { product.measurements.size == 1 }
  end

  context "should provide write access to first level attributes" do
    Given(:product) { ONIX2::Product.new }
    describe :notification_type= do
      When { product.notification_type = 3 }
      Then { product.to_xml.to_s.include? "<NotificationType>03</NotificationType>" }
    end
    describe :record_reference= do
      When { product.record_reference = "365-9780194351898" }
      Then { product.to_xml.to_s.include? "<RecordReference>365-9780194351898</RecordReference>" }
    end
    describe :product_form= do
      When { product.product_form = "BC" }
      Then { product.to_xml.to_s.include? "<ProductForm>BC</ProductForm>" }
    end
    describe :edition_number= do
      When { product.edition_number = 1 }
      Then { product.to_xml.to_s.include? "<EditionNumber>1</EditionNumber>" }
    end
    describe :number_of_pages= do
      When { product.number_of_pages = 100 }
      Then { product.to_xml.to_s.include? "<NumberOfPages>100</NumberOfPages>" }
    end
    describe :bic_main_subject= do
      When { product.bic_main_subject = "EB" }
      Then { product.to_xml.to_s.include? "<BICMainSubject>EB</BICMainSubject>" }
    end
    describe :publishing_status= do
      When { product.publishing_status = 4 }
      Then { product.to_xml.to_s.include? "<PublishingStatus>04</PublishingStatus>" }
    end
    describe  :publication_date= do
      When { product.publication_date = Date.civil(1998,9,1) }
      Then { product.to_xml.to_s.include? "<PublicationDate>19980901</PublicationDate>" }
    end
    describe :year_first_published= do
      When { product.year_first_published = 1998 }
      Then { product.to_xml.to_s.include? "<YearFirstPublished>1998</YearFirstPublished>" }
    end
  end

end

describe ONIX2::Product do

  Given(:doc) { load_xml "product_invalid_pubdate.xml" }

  describe "should correctly from_xml files that have an invalid publication date" do
    Given(:product) { ONIX2::Product.from_xml(doc) }

    Then { product.bic_main_subject == "VXFC1" }
    Then { product.publication_date.nil? }
  end

end
