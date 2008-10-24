# coding: utf-8

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')

require 'onix'

context "ONIX::Header" do

  before(:each) do
    data_path = File.join(File.dirname(__FILE__),"..","data")
    file1    = File.join(data_path, "header.xml")
    @doc = XML::Document.file(file1)
    @header_node = @doc.root
  end

  specify "should correctly convert to a string" do
    header = ONIX::Header.new(@header_node)
    header.to_s[0,8].should eql("<Header>")
  end

  specify "should initialise with an existing node" do
    header = ONIX::Header.new(@header_node)
    header.instance_variable_get("@root_node").should eql(@header_node)
  end

  specify "should create an empty node if none is provided on init" do
    header = ONIX::Header.new
    header.instance_variable_get("@root_node").should be_a_kind_of(XML::Node)
  end

  specify "should provide read access to first level attibutes" do
    header = ONIX::Header.new(@header_node)

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

  specify "should provide write access to first level attibutes" do
    header = ONIX::Header.new

    header.from_ean_number = "1111111111111"
    header.from_ean_number.should eql("1111111111111")

    header.from_san = "1111111"
    header.from_san.should eql("1111111")

    header.from_company = "Text Company"
    header.from_company.should eql("Text Company")

    header.from_email = "james@rainbowbooks.com.au"
    header.from_email.should eql("james@rainbowbooks.com.au")

    header.from_person = "James"
    header.from_person.should eql("James")

    header.to_ean_number = "2222222222222"
    header.to_ean_number.should eql("2222222222222")

    header.to_san = "2222222"
    header.to_san.should eql("2222222")

    header.to_company = "Company 2"
    header.to_company.should eql("Company 2")

    header.to_person = "Chris"
    header.to_person.should eql("Chris")

    header.message_note = "A Message"
    header.message_note.should eql("A Message")

    header.message_repeat = 1
    header.message_repeat.should eql(1)

    header.sent_date = Date.civil(2008,5,19)
    header.sent_date.should eql(Date.civil(2008,5,19))

    header.default_language_of_text = "aaa"
    header.default_language_of_text.should eql("aaa")

    header.default_price_type_code = 1
    header.default_price_type_code.should eql(1)

    header.default_currency_code = "ccc"
    header.default_currency_code.should eql("ccc")

    header.default_linear_unit = "dd"
    header.default_linear_unit.should eql("dd")

    header.default_weight_unit = "ee"
    header.default_weight_unit.should eql("ee")

    header.default_class_of_trade = "f"
    header.default_class_of_trade.should eql("f")
  end
end
