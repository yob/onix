# coding: utf-8

require File.dirname(__FILE__) + '/spec_helper.rb'

describe ONIX2::Writer do

  before(:each) do
    @output = StringIO.new
  end

  it "should output the correct xml metadata" do
    header = ONIX2::Header.new
    writer = ONIX2::Writer.new(@output, header)
    writer.end_document

    lines = @output.string.split("\n")

    # xml declaration
    expect(lines[0][0,5]).to be_eql("<?xml")

    # doctype
    expect(lines[1][0,9]).to be_eql("<!DOCTYPE")
  end

  it "should output the correct xml metadata when used in block form" do
    header = ONIX2::Header.new
    ONIX2::Writer.open(@output, header) { |writer| }

    lines = @output.string.split("\n")

    # xml declaration
    expect(lines[0][0,5]).to be_eql("<?xml")

    # doctype
    expect(lines[1][0,9]).to be_eql("<!DOCTYPE")
  end

  it "should output the header node" do
    header = ONIX2::Header.new

    ONIX2::Writer.open(@output, header) { |writer| }

    lines = @output.string.split("\n")

    expect(lines[3][0,7]).to be_eql("<Header")
  end

  it "should output the product node" do
    header = ONIX2::Header.new
    product = ONIX2::Product.new

    ONIX2::Writer.open(@output, header) do |writer|
      writer << product
    end

    lines = @output.string.split("\n")

    expect(lines[4][0,8]).to be_eql("<Product")
  end

  it "should correctly store finished state" do
    header = ONIX2::Header.new
    writer = ONIX2::Writer.new(@output, header)
    expect(writer).not_to be_finished
    writer.end_document
    expect(writer).to be_finished
  end

=begin
  it "should convert non-ASCII chars to references when outputting as a string" do
    header = ONIX2::Header.new
    header.from_person = "Hans Küng"
    ONIX2::Writer.open(@output, header) { |writer| }

    @output.string.include?("K&#252;ng").should be_true
  end
=end
end
