# coding: utf-8

require File.dirname(__FILE__) + '/spec_helper.rb'

describe ONIX::Header do

  Given{
    data_path = File.join(File.dirname(__FILE__),"..","data")
    file1    = File.join(data_path, "header.xml")
    @doc = Nokogiri::XML::Document.parse(File.read(file1))
    @header_node = @doc.root
  }

  context "should correctly convert to a string" do
    Given(:header){ ONIX::Header.from_xml(@header_node.to_s) }
    Then{ header.to_xml.to_s[0,8] == "<Header>" }
  end

  context "should provide read access to first level attributes" do
    Given(:header){ ONIX::Header.from_xml(@header_node.to_s) }

    Then{ header.from_ean_number == "1111111111111" }
    And{ header.from_san == "1111111" }
    And{ header.from_company == "Text Company" }
    And{ header.from_email == "james@rainbowbooks.com.au" }
    And{ header.from_person == "James" }

    And{ header.to_ean_number == "2222222222222" }
    And{ header.to_san == "2222222" }
    And{ header.to_company == "Company 2" }
    And{ header.to_person == "Chris" }

    And{ header.message_note == "A Message" }
    And{ header.message_repeat == 1 }
    And{ header.sent_date == Date.civil(2008,5,19) }

    And{ header.default_language_of_text == "aaa" }
    And{ header.default_price_type_code == 1 }
    And{ header.default_currency_code == "ccc" }
    And{ header.default_linear_unit == "dd" }
    And{ header.default_weight_unit == "ee" }
    And{ header.default_class_of_trade == "f" }
  end

  context "should provide write access to first level attributes" do
    Given(:header){ ONIX::Header.new }
    Given(:header_to_xml_to_s){ header.to_xml.to_s }

    When{ header.from_ean_number = "1111111111111" }
    When{ header.from_san = "1111111" }
    When{ header.from_company = "Text Company" }
    When{ header.from_email = "james@rainbowbooks.com.au" }
    When{ header.from_person = "James" }
    When{ header.to_ean_number = "2222222222222" }
    When{ header.to_san = "2222222" }
    When{ header.to_company = "Company 2" }
    When{ header.to_person = "Chris" }
    When{ header.message_note = "A Message" }
    When{ header.message_repeat = 1 }
    When{ header.sent_date = Date.civil(2008,5,19) }
    When{ header.default_language_of_text = "aaa" }
    When{ header.default_price_type_code = 1 }
    When{ header.default_currency_code = "ccc" }
    When{ header.default_class_of_trade = "f" }

    Then{ header_to_xml_to_s.include?("<FromEANNumber>1111111111111</FromEANNumber>") == true }
    And{ header_to_xml_to_s.include?("<FromSAN>1111111</FromSAN>") == true }
    And{ header_to_xml_to_s.include?("<FromCompany>Text Company</FromCompany>") == true }
    And{ header_to_xml_to_s.include?("<FromEmail>james@rainbowbooks.com.au</FromEmail>") == true }
    And{ header_to_xml_to_s.include?("<FromPerson>James</FromPerson>") == true }
    And{ header_to_xml_to_s.include?("<ToEANNumber>2222222222222</ToEANNumber>") == true }
    And{ header_to_xml_to_s.include?("<ToSAN>2222222</ToSAN>") == true }
    And{ header_to_xml_to_s.include?("<ToCompany>Company 2</ToCompany>") == true }
    And{ header_to_xml_to_s.include?("<ToPerson>Chris</ToPerson>") == true }
    And{ header_to_xml_to_s.include?("<MessageNote>A Message</MessageNote>") == true }
    And{ header_to_xml_to_s.include?("<MessageRepeat>1</MessageRepeat>") == true }
    And{ header_to_xml_to_s.include?("<SentDate>20080519</SentDate>") == true }
    And{ header_to_xml_to_s.include?("<DefaultLanguageOfText>aaa</DefaultLanguageOfText>") == true }
    And{ header_to_xml_to_s.include?("<DefaultPriceTypeCode>01</DefaultPriceTypeCode>") == true }
    And{ header_to_xml_to_s.include?("<DefaultCurrencyCode>ccc</DefaultCurrencyCode>") == true }
    And{ header_to_xml_to_s.include?("<DefaultClassOfTrade>f</DefaultClassOfTrade>") == true }
  end

  context "should correctly handle text with & < and >" do
    Given(:header){ ONIX::Header.new }
    Given(:header_to_xml_to_s){ header.to_xml.to_s }

    context "with &" do
      When{ header.from_company = "James & Healy" }
      Then{ header_to_xml_to_s.include?("James &amp; Healy") == true }
    end

    context "with <" do
      When{ header.from_company = "James < Healy" }
      Then{ header_to_xml_to_s.include?("James &lt; Healy") == true }
    end

    context "with >" do
      When{ header.from_company = "James > Healy" }
      Then{ header_to_xml_to_s.include?("James &gt; Healy") == true }
    end
  end

end

describe ONIX::Header do

  Given{
    data_path = File.join(File.dirname(__FILE__),"..","data")
    @file = File.join(data_path, "header_invalid_sentdate.xml")
  }

  context "should correctly handle headers with an invalid sent date" do
    Given(:header){ ONIX::Header.from_xml(File.read(@file)) }

    Then{ header.sent_date == nil }
  end

end
