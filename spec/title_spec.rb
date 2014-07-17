# coding: utf-8

require File.dirname(__FILE__) + '/spec_helper.rb'

describe ONIX::Title do

  Given{
    data_path = File.join(File.dirname(__FILE__),"..","data")
    file1    = File.join(data_path, "title.xml")
    @doc     = Nokogiri::XML::Document.parse(File.read(file1))
    @root = @doc.root
  }

  context "should correctly convert to a string" do
    Given(:title){ ONIX::Title.from_xml(@root.to_s) }
    Then{ title.to_xml.to_s[0,7] == "<Title>" }
  end

  context "should provide read access to first level attributes" do
    Given(:title){ ONIX::Title.from_xml(@root.to_s) }

    Then{ title.title_type == 1 }
    And{ title.title_text == "Good Grief" }
    And{ title.subtitle == "A Constructive Approach to the Problem of Loss" }
  end

  context "should provide write access to first level attributes" do
    Given(:title){ ONIX::Title.new }

    When{ title.title_type = 1 }
    When{ title.title_text = "Good Grief" }
    When{ title.subtitle = "Blah" }

    Then{ title.to_xml.to_s.include?("<TitleType>01</TitleType>") == true }
    And{ title.to_xml.to_s.include?("<TitleText>Good Grief</TitleText>") == true }
    And{ title.to_xml.to_s.include?("<Subtitle>Blah</Subtitle>") == true }
  end

end

