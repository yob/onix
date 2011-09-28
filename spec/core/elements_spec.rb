# coding: utf-8

require 'spec_helper.rb'

describe ONIX::Element, "custom accessors" do

  before(:all) do
    class ONIX::TestElement < ONIX::Element
      xml_name "TestElement"
      onix_date_accessor(:test_date, "TestDate")
      onix_date_accessor(:m_dates, "MDate", :as => [Date])
      onix_composite(:websites, ONIX::Website)
      onix_space_separated_list(:countries, "CountryCodes")
      onix_code_from_list(:update_code, "UpdateCode", :list => 1)
      onix_codes_from_list(:identifiers, "Identifier", :list => 5)
      onix_code_from_list(:lax_identifier, "LaxIdentifier", :list => 5, :enforce => false)
      onix_code_from_list(:strict_identifier, "StrictIdentifier", :list => 5, :enforce => true)
      onix_boolean_flag(:no_dice, "NoDice")
      onix_boolean_flag(:no_cigar, "NoCigar")
    end
  end


  it "should load dates" do
    xml = %Q`
      <TestElement>
        <TestDate>20010101</TestDate>
      </TestElement>
    `
    elem = ONIX::TestElement.from_xml(xml)
    elem.test_date.should eql(Date.parse("2001-01-01"))
  end


  it "should load multiple test dates correctly" do
    xml = %Q`
      <TestElement>
        <MDate>20010101</MDate>
        <MDate>20100101</MDate>
      </TestElement>
    `
    elem = ONIX::TestElement.from_xml(xml)
    elem.m_dates.size.should eql(2)
  end


  it "should load composites" do
    xml = %Q`
      <TestElement>
        <Website>
          <WebsiteRole>01</WebsiteRole>
          <WebsiteLink>http://www.rainbowbooks.com.au</WebsiteLink>
        </Website>
        <Website>
          <WebsiteRole>02</WebsiteRole>
          <WebsiteDescription>Web-based ebooks!</WebsiteDescription>
          <WebsiteLink>http://booki.sh</WebsiteLink>
        </Website>
      </TestElement>
    `
    elem = ONIX::TestElement.from_xml(xml)
    elem.websites.size.should eql(2)
    elem.websites[1].website_description.should eql("Web-based ebooks!")
  end


  it "should load space-separated lists" do
    xml = %Q`
      <TestElement>
        <CountryCodes>AU NZ US</CountryCodes>
      </TestElement>
    `
    elem = ONIX::TestElement.from_xml(xml)
    elem.countries.should eql(["AU", "NZ", "US"])
  end


  it "should load a code from a list" do
    xml = %Q`
      <TestElement>
        <UpdateCode>01</UpdateCode>
      </TestElement>
    `
    elem = ONIX::TestElement.from_xml(xml)
    elem.update_code.should eql(1)
    elem.update_code_code.value.should eql("Early notification")
  end


  it "should load multiple codes from a list into an array" do
    xml = %Q`
      <TestElement>
        <Identifier>04</Identifier>
        <Identifier>22</Identifier>
      </TestElement>
    `
    elem = ONIX::TestElement.from_xml(xml)
    elem.identifiers.should eql([4, 22])
    elem.identifiers_codes.collect { |c| c.value }.should eql(["UPC", "URN"])
  end


  it "should nil invalid values from a list by default" do
    xml = %Q`
      <TestElement>
        <Identifier>This is not a valid code in the list</Identifier>
      </TestElement>
    `
    elem = ONIX::TestElement.from_xml(xml)
    elem.identifiers_codes.first.value.should be_nil
  end


  it "should permit invalid values from a list if enforce option false" do
    inv = "This is not a valid code in the list"
    xml = %Q`
      <TestElement>
        <LaxIdentifier>#{inv}</LaxIdentifier>
      </TestElement>
    `
    elem = ONIX::TestElement.from_xml(xml)
    elem.lax_identifier_code.value.should eql(inv)
  end


  it "should raise invalid values from a list if enforce option true" do
    xml = %Q`
      <TestElement>
        <StrictIdentifier>This is not a valid code in the list</StrictIdentifier>
      </TestElement>
    `
    lambda { ONIX::TestElement.from_xml(xml) }.should raise_error
  end


  it "should recognise boolean flags" do
    xml = "<TestElement><NoDice /></TestElement>"
    elem = ONIX::TestElement.from_xml(xml)
    elem.no_dice.should be_true
    elem.no_cigar.should be_false
  end


  it "should fetch a single composite with an attribute value matching query" do
    xml = %Q`
      <TestElement>
        <Website>
          <WebsiteRole>01</WebsiteRole>
          <WebsiteLink>http://www.rainbowbooks.com.au</WebsiteLink>
        </Website>
        <Website>
          <WebsiteRole>01</WebsiteRole>
          <WebsiteDescription>Web-based ebooks!</WebsiteDescription>
          <WebsiteLink>http://booki.sh</WebsiteLink>
        </Website>
      </TestElement>
    `
    elem = ONIX::TestElement.from_xml(xml)
    website = elem.fetch(:websites, :website_role, 1)
    website.should_not be_nil
    website.website_link.should eql("http://www.rainbowbooks.com.au")
  end

  it "should fetch a composite array with attribute values matching query" do
    xml = %Q`
      <TestElement>
        <Website>
          <WebsiteRole>01</WebsiteRole>
          <WebsiteLink>http://www.rainbowbooks.com.au</WebsiteLink>
        </Website>
        <Website>
          <WebsiteRole>01</WebsiteRole>
          <WebsiteDescription>Web-based ebooks!</WebsiteDescription>
          <WebsiteLink>http://booki.sh</WebsiteLink>
        </Website>
      </TestElement>
    `
    elem = ONIX::TestElement.from_xml(xml)
    websites = elem.fetch_all(:websites, :website_role, 1)
    websites.should_not be_empty
    websites.collect { |ws| ws.website_link }.should eql([
      "http://www.rainbowbooks.com.au",
      "http://booki.sh"
    ])
  end

  it "should fetch a composite array with attribute values matching queries" do
    xml = %Q`
      <TestElement>
        <Website>
          <WebsiteRole>01</WebsiteRole>
          <WebsiteLink>http://www.rainbowbooks.com.au</WebsiteLink>
        </Website>
        <Website>
          <WebsiteRole>02</WebsiteRole>
          <WebsiteDescription>Web-based ebooks!</WebsiteDescription>
          <WebsiteLink>http://booki.sh</WebsiteLink>
        </Website>
      </TestElement>
    `
    elem = ONIX::TestElement.from_xml(xml)
    websites1 = elem.fetch_all(:websites, :website_role, 1)
    websites1.size.should eql(1)
    websites2 = elem.fetch_all(:websites, :website_role, [1,2])
    websites2.size.should eql(2)
  end

end
