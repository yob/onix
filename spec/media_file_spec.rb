# coding: utf-8

require File.dirname(__FILE__) + '/spec_helper.rb'

context "ONIX::MediaFile" do

  before(:each) do
    data_path = File.join(File.dirname(__FILE__),"..","data")
    file1    = File.join(data_path, "media_file.xml")
    @doc     = Nokogiri::XML::Document.parse(File.read(file1))
    @root = @doc.root
  end

  specify "should correctly convert to a string" do
    mf = ONIX::MediaFile.from_xml(@root.to_s)
    mf.to_xml.to_s[0,11].should eql("<MediaFile>")
  end

  specify "should provide read access to first level attributes" do
    mf = ONIX::MediaFile.from_xml(@root.to_s)
    mf.media_file_type_code.should eql(4)
    mf.media_file_link_type_code.should eql(1)
    mf.media_file_link.should eql("http://www.allenandunwin.com/BookCovers/resized_9788888028729_224_297_FitSquare.jpg")
  end

  specify "should provide write access to first level attributes" do
    mf = ONIX::MediaFile.new

    mf.media_file_type_code = 2
    mf.to_xml.to_s.include?("<MediaFileTypeCode>02</MediaFileTypeCode>").should be_true

    mf.media_file_link_type_code = 1
    mf.to_xml.to_s.include?("<MediaFileLinkTypeCode>01</MediaFileLinkTypeCode>").should be_true

    mf.media_file_link = "http://www.google.com"
    mf.to_xml.to_s.include?("<MediaFileLink>http://www.google.com</MediaFileLink>").should be_true
  end

end

