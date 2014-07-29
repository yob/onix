# coding: utf-8

require 'spec_helper'

describe ONIX::Header do

  Given(:doc) { load_xml "header.xml" }

  describe "should correctly convert to a string" do
    Given(:header) { ONIX::Header.from_xml(doc) }
    Then { header.to_xml.to_s.start_with? "<Header>" }
  end

  describe "should provide read access to first level attributes" do
    Given(:header) { ONIX::Header.from_xml(doc) }

    Then { header.from_ean_number == "1111111111111" }
    Then { header.from_san == "1111111" }
    Then { header.from_company == "Text Company" }
    Then { header.from_email == "james@rainbowbooks.com.au" }
    Then { header.from_person == "James" }
    Then { header.to_ean_number == "2222222222222" }
    Then { header.to_san == "2222222" }
    Then { header.to_company == "Company 2" }
    Then { header.to_person == "Chris" }
    Then { header.message_note == "A Message" }
    Then { header.message_repeat == 1 }
    Then { header.sent_date == Date.civil(2008,5,19) }
    Then { header.default_language_of_text == "aaa" }
    Then { header.default_price_type_code == 1 }
    Then { header.default_currency_code == "ccc" }
    Then { header.default_linear_unit == "dd" }
    Then { header.default_weight_unit == "ee" }
    Then { header.default_class_of_trade == "f" }
  end

  context "should provide write access to first level attributes" do
    Given(:header) { ONIX::Header.new }
    describe :from_ean_number= do
      When { header.from_ean_number = "1111111111111" }
      Then { header.to_xml.to_s.include? "<FromEANNumber>1111111111111</FromEANNumber>" }
    end
    describe :from_san= do
      When { header.from_san = "1111111" }
      Then { header.to_xml.to_s.include? "<FromSAN>1111111</FromSAN>" }
    end
    describe :from_company= do
      When { header.from_company = "Text Company" }
      Then { header.to_xml.to_s.include? "<FromCompany>Text Company</FromCompany>" }
    end
    describe :from_email= do
      When { header.from_email = "james@rainbowbooks.com.au" }
      Then { header.to_xml.to_s.include? "<FromEmail>james@rainbowbooks.com.au</FromEmail>" }
    end
    describe :from_person= do
      When { header.from_person = "James" }
      Then { header.to_xml.to_s.include? "<FromPerson>James</FromPerson>" }
    end
    describe :to_ean_number= do
      When { header.to_ean_number = "2222222222222" }
      Then { header.to_xml.to_s.include? "<ToEANNumber>2222222222222</ToEANNumber>" }
    end
    describe :to_san= do
      When { header.to_san = "2222222" }
      Then { header.to_xml.to_s.include? "<ToSAN>2222222</ToSAN>" }
    end
    describe :to_company= do
      When { header.to_company = "Company 2" }
      Then { header.to_xml.to_s.include? "<ToCompany>Company 2</ToCompany>" }
    end
    describe :to_person= do
      When { header.to_person = "Chris" }
      Then { header.to_xml.to_s.include? "<ToPerson>Chris</ToPerson>" }
    end
    describe :message_note= do
      When { header.message_note = "A Message" }
      Then { header.to_xml.to_s.include? "<MessageNote>A Message</MessageNote>" }
    end
    describe :message_repeat= do
      When { header.message_repeat = 1 }
      Then { header.to_xml.to_s.include? "<MessageRepeat>1</MessageRepeat>" }
    end
    describe :sent_date= do
      When { header.sent_date = Date.civil(2008,5,19) }
      Then { header.to_xml.to_s.include? "<SentDate>20080519</SentDate>" }
    end
    describe :default_language_of_text= do
      When { header.default_language_of_text = "aaa" }
      Then { header.to_xml.to_s.include? "<DefaultLanguageOfText>aaa</DefaultLanguageOfText>" }
    end
    describe :default_price_type_code= do
      When { header.default_price_type_code = 1 }
      Then { header.to_xml.to_s.include? "<DefaultPriceTypeCode>01</DefaultPriceTypeCode>" }
    end
    describe :default_currency_code= do
      When { header.default_currency_code = "ccc" }
      Then { header.to_xml.to_s.include? "<DefaultCurrencyCode>ccc</DefaultCurrencyCode>" }
    end
    describe :default_class_of_trade= do
      When { header.default_class_of_trade = "f" }
      Then { header.to_xml.to_s.include? "<DefaultClassOfTrade>f</DefaultClassOfTrade>" }
    end
  end

  context "should correctly handle text with & < and >" do
    Given(:header) { ONIX::Header.new }

    describe "with &" do
      When { header.from_company = "James & Healy" }
      Then { header.to_xml.to_s.include?("James &amp; Healy") }
    end

    describe "with <" do
      When { header.from_company = "James < Healy" }
      Then { header.to_xml.to_s.include?("James &lt; Healy") }
    end

    describe "with >" do
      When { header.from_company = "James > Healy" }
      Then { header.to_xml.to_s.include?("James &gt; Healy") }
    end
  end

  describe "should provide read access to sender IDs" do
    Given(:header) { ONIX::Header.from_xml(doc) }
    Then { header.sender_identifiers.size == 2 }
  end

  context "should provide write access to addressee IDs" do
    Given(:addressee_identifier1) { ONIX::AddresseeIdentifier.new(addressee_id_type: 1) }
    Given(:addressee_identifier2) { ONIX::AddresseeIdentifier.new(id_value: 20002) }
    Given(:header) { ONIX::Header.new }

    describe :addressee_identifiers= do
      When { header.addressee_identifiers = [addressee_identifier1, addressee_identifier2] }

      Then { header.to_xml.to_s.include? "<AddresseeIDType>01</AddresseeIDType>" }
      Then { header.to_xml.to_s.include? "<IDValue>20002</IDValue>" }
    end
  end

end

describe ONIX::Header do

  Given(:doc) { load_xml "header_invalid_sentdate.xml" }

  context "should correctly handle headers with an invalid sent date" do
    Given(:header) { ONIX::Header.from_xml(doc) }
    Then { header.sent_date.nil? }
  end

end
