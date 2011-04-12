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

end
