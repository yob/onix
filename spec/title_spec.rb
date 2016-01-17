# coding: utf-8

require 'spec_helper'

describe ONIX2::Title do

  Given(:doc) { load_xml "title.xml" }

  describe "should correctly convert to a string" do
    Given(:title) { ONIX2::Title.from_xml(doc) }
    Then { title.to_xml.to_s.start_with? "<Title>" }
  end

  describe "should provide read access to first level attributes" do
    Given(:title){ ONIX2::Title.from_xml(doc) }

    Then { title.title_type == 1 }
    Then { title.title_text == "Good Grief" }
    Then { title.subtitle == "A Constructive Approach to the Problem of Loss" }
  end

  context "should provide write access to first level attributes" do
    Given(:title){ ONIX2::Title.new }
    describe :title_type= do
      When { title.title_type = 1 }
      Then { title.to_xml.to_s.include? "<TitleType>01</TitleType>" }
    end
    describe :title_text= do
      When { title.title_text = "Good Grief" }
      Then { title.to_xml.to_s.include? "<TitleText>Good Grief</TitleText>" }
    end
    describe :subtitle= do
      When { title.subtitle = "Blah" }
      Then { title.to_xml.to_s.include? "<Subtitle>Blah</Subtitle>" }
    end
  end

end
