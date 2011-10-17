# coding: utf-8

require 'spec_helper.rb'

describe ONIX::Writer do

  before(:each) do
    @output = StringIO.new
  end

  it "should output the correct xml metadata" do
    header = ONIX::Header.new
    writer = ONIX::Writer.new(@output, header)
    writer.end_document

    lines = @output.string.split("\n")

    # xml declaration
    lines[0][0,5].should eql("<?xml")

    # doctype
    lines[1][0,9].should eql("<!DOCTYPE")
  end

  it "should output the correct xml metadata when used in block form" do
    header = ONIX::Header.new
    ONIX::Writer.open(@output, header) { |writer| }

    lines = @output.string.split("\n")

    # xml declaration
    lines[0][0,5].should eql("<?xml")

    # doctype
    lines[1][0,9].should eql("<!DOCTYPE")
  end

  it "should output the header node" do
    header = ONIX::Header.new

    ONIX::Writer.open(@output, header) { |writer| }

    lines = @output.string.split("\n")

    lines[3][0,7].should eql("<Header")
  end

  it "should output the product node" do
    header = ONIX::Header.new
    product = ONIX::Product.new

    ONIX::Writer.open(@output, header) do |writer|
      writer << product
    end

    lines = @output.string.split("\n")

    lines[4][0,8].should eql("<Product")
  end


  it "should output product nodes created and yielded by writer" do
    header = ONIX::Header.new
    ONIX::Writer.open(@output, header, :class => ONIX::APAProduct) do |writer|
      writer.product do |product|
        product.title = "Grimm's Fairy Tales"
        product.publication_date = Date.parse("2011-04-13")
      end
    end
    out = @output.string
    out.should include("<TitleText>Grimm's Fairy Tales</TitleText>")
    out.should include("<PublicationDate>20110413</PublicationDate>")
  end

  it "should output product nodes with interpretations" do
    ONIX::Writer.open(
      @output,
      ONIX::Header.new,
      :interpret => ONIX::SpecInterpretations::Setters
    ) do |writer|
      writer.product { |p| p.title = "Grimm's Fairy Tales" }
    end
    out = @output.string
    out.should include("<TitleText>Grimm's Fairy Tales</TitleText>")
  end

  it "should correctly store finished state" do
    header = ONIX::Header.new
    writer = ONIX::Writer.new(@output, header)
    writer.finished?.should be_false
    writer.end_document
    writer.finished?.should be_true
  end

=begin
  it "should convert non-ASCII chars to references when outputting as a string" do
    header = ONIX::Header.new
    header.from_person = "Hans Küng"
    ONIX::Writer.open(@output, header) { |writer| }

    @output.string.include?("K&#252;ng").should be_true
  end
=end
end
