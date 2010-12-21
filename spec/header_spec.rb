# coding: utf-8

require File.dirname(__FILE__) + '/spec_helper.rb'

describe ONIX::Header do

  before(:each) do
    data_path = File.join(File.dirname(__FILE__),"..","data")
    file1    = File.join(data_path, "header.xml")
    @doc = Nokogiri::XML::Document.parse(File.read(file1))
    @header_node = @doc.root
  end

  it "should correctly convert to a string" do
    header = ONIX::Header.from_xml(@header_node.to_s)
    header.to_xml.to_s[0,8].should eql("<Header>")
  end

  it "should provide read access to first level attributes" do
    header = ONIX::Header.from_xml(@header_node.to_s)

    header.from_ean_number.should eql("1111111111111")
    header.from_san.should eql("1111111")
    header.from_company.should eql("Text Company")
    header.from_email.should eql("james@rainbowbooks.com.au")
    header.from_person.should eql("James")

    header.to_ean_number.should eql("2222222222222")
    header.to_san.should eql("2222222")
    header.to_company.should eql("Company 2")
    header.to_person.should eql("Chris")

    header.message_note.should eql("A Message")
    header.message_repeat.should eql(1)
    header.sent_date.should eql(Date.civil(2008,5,19))

    header.default_language_of_text.should eql("aaa")
    header.default_price_type_code.should eql(1)
    header.default_currency_code.should eql("ccc")
    header.default_linear_unit.should eql("dd")
    header.default_weight_unit.should eql("ee")
    header.default_class_of_trade.should eql("f")
  end

  it "should provide write access to first level attributes" do
    header = ONIX::Header.new

    header.from_ean_number = "1111111111111"
    #puts header.to_xml.to_s
    header.to_xml.to_s.include?("<FromEANNumber>1111111111111</FromEANNumber>").should be_true

    header.from_san = "1111111"
    header.to_xml.to_s.include?("<FromSAN>1111111</FromSAN>").should be_true

    header.from_company = "Text Company"
    header.to_xml.to_s.include?("<FromCompany>Text Company</FromCompany>").should be_true

    header.from_email = "james@rainbowbooks.com.au"
    header.to_xml.to_s.include?("<FromEmail>james@rainbowbooks.com.au</FromEmail>").should be_true

    header.from_person = "James"
    header.to_xml.to_s.include?("<FromPerson>James</FromPerson>").should be_true

    header.to_ean_number = "2222222222222"
    header.to_xml.to_s.include?("<ToEANNumber>2222222222222</ToEANNumber>").should be_true

    header.to_san = "2222222"
    header.to_xml.to_s.include?("<ToSAN>2222222</ToSAN>").should be_true

    header.to_company = "Company 2"
    header.to_xml.to_s.include?("<ToCompany>Company 2</ToCompany>").should be_true

    header.to_person = "Chris"
    header.to_xml.to_s.include?("<ToPerson>Chris</ToPerson>").should be_true

    header.message_note = "A Message"
    header.to_xml.to_s.include?("<MessageNote>A Message</MessageNote>").should be_true

    header.message_repeat = 1
    header.to_xml.to_s.include?("<MessageRepeat>1</MessageRepeat>").should be_true

    header.sent_date = Date.civil(2008,5,19)
    header.to_xml.to_s.include?("<SentDate>20080519</SentDate>").should be_true

    header.default_language_of_text = "aaa"
    header.to_xml.to_s.include?("<DefaultLanguageOfText>aaa</DefaultLanguageOfText>").should be_true

    header.default_price_type_code = 1
    header.to_xml.to_s.include?("<DefaultPriceTypeCode>01</DefaultPriceTypeCode>").should be_true

    header.default_currency_code = "ccc"
    header.to_xml.to_s.include?("<DefaultCurrencyCode>ccc</DefaultCurrencyCode>").should be_true

    header.default_class_of_trade = "f"
    header.to_xml.to_s.include?("<DefaultClassOfTrade>f</DefaultClassOfTrade>").should be_true
  end

  it "should correctly handle text with & < and >" do
    header = ONIX::Header.new

    header.from_company = "James & Healy"
    header.to_xml.to_s.include?("James &amp; Healy").should be_true

    header.from_company = "James < Healy"
    header.to_xml.to_s.include?("James &lt; Healy").should  be_true

    header.from_company = "James > Healy"
    header.to_xml.to_s.include?("James &gt; Healy").should  be_true
  end
end

describe ONIX::Header do

  it "should correctly handle headers with an invalid sent date" do
    data_path = File.join(File.dirname(__FILE__),"..","data")
    file = File.join(data_path, "header_invalid_sentdate.xml")
    header = ONIX::Header.from_xml(File.read(file))

    header.sent_date.should be_nil
  end
end
