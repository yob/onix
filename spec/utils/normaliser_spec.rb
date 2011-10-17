# coding: utf-8

require 'spec_helper.rb'

describe ONIX::Normaliser, "with a simple short tag file" do

  before(:each) do
    @filename = find_data_file("short_tags.xml")
    @outfile = @filename + ".new"
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
    @filename = find_data_file("short_tags_ivp.xml")
    @outfile = @filename + ".new"
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
    @filename = find_data_file("control_chars.xml")
    @outfile = @filename + ".new"
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
