# coding: utf-8

require 'spec_helper'

describe ONIX::MediaFile do

  Given(:doc) { load_xml "media_file.xml" }

  describe "should correctly convert to a string" do
    Given(:mf) { ONIX::MediaFile.from_xml(doc) }
    Then { mf.to_xml.to_s.start_with? "<MediaFile>" }
  end

  describe "should provide read access to first level attributes" do
    Given(:mf) { ONIX::MediaFile.from_xml(doc) }

    Then { mf.media_file_type_code == 4 }
    Then { mf.media_file_link_type_code == 1 }
    Then { mf.media_file_link == "http://www.allenandunwin.com/BookCovers/resized_9788888028729_224_297_FitSquare.jpg" }
  end

  context "should provide write access to first level attributes" do
    Given(:mf) { ONIX::MediaFile.new }
    describe :media_file_type_code= do
      When { mf.media_file_type_code = 2 }
      Then { mf.to_xml.to_s.include? "<MediaFileTypeCode>02</MediaFileTypeCode>" }
    end
    describe :media_file_link_type_code= do
      When { mf.media_file_link_type_code = 1 }
      Then { mf.to_xml.to_s.include? "<MediaFileLinkTypeCode>01</MediaFileLinkTypeCode>" }
    end
    describe :media_file_link= do
      When { mf.media_file_link = "http://www.google.com" }
      Then { mf.to_xml.to_s.include? "<MediaFileLink>http://www.google.com</MediaFileLink>" }
    end
  end

end
