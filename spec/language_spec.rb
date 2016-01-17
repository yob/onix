# coding: utf-8

require 'spec_helper'

describe ONIX2::Language do

  Given(:doc) { load_xml "language.xml" }

  describe "should correctly convert to a string" do
    Given(:lan) { ONIX2::Language.from_xml(doc) }
    Then { lan.to_xml.to_s.start_with? "<Language>" }
  end

  describe "should provide read access to first level attributes" do
    Given(:lan) { ONIX2::Language.from_xml(doc) }

    Then { lan.language_role == 1 }
    Then { lan.language_code == "eng" }
    Then { lan.country_code == "US" }
  end

  context "should provide write access to first level attributes" do
    Given(:lan) { ONIX2::Language.new }
    describe :language_role= do
      When { lan.language_role = 2 }
      Then { lan.to_xml.to_s.include? "<LanguageRole>02</LanguageRole>" }
    end
    describe :language_code= do
      When { lan.language_code = "aar" }
      Then { lan.to_xml.to_s.include? "<LanguageCode>aar</LanguageCode>" }
    end
    describe :country_code= do
      When { lan.country_code = "AD" }
      Then { lan.to_xml.to_s.include? "<CountryCode>AD</CountryCode>" }
    end
  end

end
