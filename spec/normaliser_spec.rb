# coding: utf-8

require File.dirname(__FILE__) + '/spec_helper.rb'

describe ONIX::Normaliser, "with a simple short tag file" do

  before(:each) do
    @data_path = File.join(File.dirname(__FILE__),"..","data")
    @filename  = File.join(@data_path, "short_tags.xml")
    @outfile   = @filename + ".new"
  end

  after(:each) do
    File.unlink(@outfile) if File.file?(@outfile)
  end

  it "should correctly convert short tag file to reference tag" do
    ONIX::Normaliser.process(@filename, @outfile)

    File.file?(@outfile).should be_true
    content = File.read(@outfile)
    content.include?("<m174>").should be_false
    content.include?("<FromCompany>").should be_true
  end
end

describe ONIX::Normaliser, "with a short tag file that include HTML tags" do

  before(:each) do
    @data_path = File.join(File.dirname(__FILE__),"..","data")
    @filename  = File.join(@data_path, "short_tags_ivp.xml")
    @outfile   = @filename + ".new"
  end

  after(:each) do
    File.unlink(@outfile) if File.file?(@outfile)
  end

  it "should correctly convert short tag file to reference tag" do
    ONIX::Normaliser.process(@filename, @outfile)

    File.file?(@outfile).should be_true
    content = File.read(@outfile)
    content.include?("<m174>").should be_false
    content.include?("<FromCompany>").should be_true
    content.include?("<em>Discipleship Essentials</em>").should be_true
  end

end

describe ONIX::Normaliser, "with a utf8 file that has illegal control chars" do

  before(:each) do
    @data_path = File.join(File.dirname(__FILE__),"..","data")
    @filename  = File.join(@data_path, "control_chars.xml")
    @outfile   = @filename + ".new"
  end

  after(:each) do
    File.unlink(@outfile) if File.file?(@outfile)
  end

  it "should remove all control chars except LF, CR and TAB" do
    ONIX::Normaliser.process(@filename, @outfile)

    File.file?(@outfile).should be_true
    content = File.read(@outfile)

    content.include?("<TitleText>OXFORDPICTURE DICTIONARY CHINESE</TitleText>").should be_true
  end
end

describe ONIX::Normaliser, "with an iso-8859-1 file that is not declared as such" do

  before(:each) do
    @data_path = File.join(File.dirname(__FILE__),"..","data")
    @filename  = File.join(@data_path, "aau.xml")
    @outfile   = "/tmp/" + File.basename(@filename) + ".new"
  end

  after(:each) do
    File.unlink(@outfile) if File.file?(@outfile)
  end

  it "should add an encoding declaration if requested" do
    ONIX::Normaliser.process(@filename, @outfile, :encoding => "iso-8859-1")

    File.file?(@outfile).should be_true
    content = File.read(@outfile)

    content[0,44].should eql('<?xml version="1.0" encoding="iso-8859-1" ?>')
  end
end

describe ONIX::Normaliser, "with a file that has no XML declaration" do

  before(:each) do
    @data_path = File.join(File.dirname(__FILE__),"..","data")
    @filename  = File.join(@data_path, "no_xml_declaration.xml")
    @outfile   = "/tmp/" + File.basename(@filename) + ".new"
  end

  after(:each) do
    File.unlink(@outfile) if File.file?(@outfile)
  end

  it "should add an encoding declaration if requested" do
    ONIX::Normaliser.process(@filename, @outfile, :encoding => "iso-8859-1")

    File.file?(@outfile).should be_true
    content = File.read(@outfile)

    content[0,44].should eql('<?xml version="1.0" encoding="iso-8859-1" ?>')
  end
end
