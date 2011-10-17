# coding: utf-8

require 'spec_helper.rb'

describe ONIX::MediaFile do

  before(:each) do
    load_doc_and_root("media_file.xml")
  end

  it "should correctly convert to a string" do
    mf = ONIX::MediaFile.from_xml(@root.to_s)
    mf.to_xml.to_s[0,11].should eql("<MediaFile>")
  end

  it "should provide read access to first level attributes" do
    mf = ONIX::MediaFile.from_xml(@root.to_s)
    mf.media_file_type_code.should eql(4)
    mf.media_file_link_type_code.should eql(1)
    mf.media_file_link.should eql("http://www.allenandunwin.com/BookCovers/resized_9788888028729_224_297_FitSquare.jpg")
  end

  it "should provide write access to first level attributes" do
    mf = ONIX::MediaFile.new

    mf.media_file_type_code = 2
    mf.to_xml.to_s.include?("<MediaFileTypeCode>02</MediaFileTypeCode>").should be_true

    mf.media_file_link_type_code = 1
    mf.to_xml.to_s.include?("<MediaFileLinkTypeCode>01</MediaFileLinkTypeCode>").should be_true

    mf.media_file_link = "http://www.google.com"
    mf.to_xml.to_s.include?("<MediaFileLink>http://www.google.com</MediaFileLink>").should be_true
  end

end

