# coding: utf-8

require File.dirname(__FILE__) + '/spec_helper.rb'

describe ONIX::Reader do

  before(:each) do
    @data_path = File.join(File.dirname(__FILE__),"..","data")
    @file1    = File.join(@data_path, "9780194351898.xml")
    @file2    = File.join(@data_path, "two_products.xml")
    @long_file   = File.join(@data_path, "Bookwise_July_2008.xml")
    @entity_file = File.join(@data_path, "entities.xml")
    @utf_16_file = File.join(@data_path, "utf_16.xml")
    @iso_8859_1_file = File.join(@data_path, "iso_8859_1.xml")
    @no_encoding_decl_file = File.join(@data_path, "aau.xml")
  end

  it "should initialize with a filename" do
    reader = ONIX::Reader.new(@file1)
    reader.instance_variable_get("@reader").should be_a_kind_of(Nokogiri::XML::Reader)
  end

  it "should initialize with an IO object" do
    File.open(@file1,"rb") do |f|
      reader = ONIX::Reader.new(f)
      reader.instance_variable_get("@reader").should be_a_kind_of(Nokogiri::XML::Reader)
    end
  end

  it "should provide access to various XML metadata from file" do
    filename = File.join(@data_path, "reference_with_release_attrib.xml")
    reader = ONIX::Reader.new(filename)
    reader.release.should eql(BigDecimal.new("2.1"))
  end

  it "should provide access to the header in an ONIX file" do
    reader = ONIX::Reader.new(@file1)
    reader.header.should be_a_kind_of(ONIX::Header)
  end

  it "should iterate over all product records in an ONIX file" do
    reader = ONIX::Reader.new(@file1)
    counter = 0
    reader.each do |product|
      product.should be_a_kind_of(ONIX::Product)
      counter += 1
    end

    counter.should eql(1)
  end

  it "should iterate over all product records in an ONIX file" do
    reader = ONIX::Reader.new(@file2)
    products = []
    reader.each do |product|
      products << product
    end

    products.size.should eql(2)
    products[0].record_reference.should eql("365-9780194351898")
    products[1].record_reference.should eql("9780754672326")
  end

  # libxml can handle the 3 standard entities fine (&amp; &lt; and ^gt;) but
  # barfs when it encounters others. In theory other entities are defined in the
  # ONIX DTD, but I can't work out how to get libxml to recognise them
  it "should correctly parse a file that has an entity in it" do
    reader = ONIX::Reader.new(@entity_file)

    products = []
    reader.each do |product|
      products << product
    end

    products.size.should eql(1)
    products.first.titles.size.should eql(1)
    products.first.titles.first.title_text.should eql("High Noon\342\200\223in Nimbin")
    products.first.record_reference.should eql("9780732287573")
  end

  # for some reason I'm getting segfaults when I read a file with more than 7 records
  it "should correctly parse a file with more than 7 records in in" do
    reader = ONIX::Reader.new(@long_file)
    counter = 0
    reader.each do |product|
      counter += 1
    end

    counter.should eql(346)
  end

  it "should transparently convert a iso-8859-1 file to utf-8" do
    reader = ONIX::Reader.new(@iso_8859_1_file)
    reader.each do |product|
      if RUBY_VERSION >= "1.9"
        utf8 = Encoding.find("utf-8")
        product.contributors[0].person_name_inverted.encoding.should eql(utf8)
      end

      product.contributors[0].person_name_inverted.should eql("Küng, Hans")
    end
  end

  # This isn't ideal behaviour, but i'm somewhat hamstrung by nokogiri API. It'd
  # be nice to have the option to replace unrecognised bytes with a valid char.
  it "should raise an exception when an iso-8859-1 file isn't declared as such" do
    reader = ONIX::Reader.new(@no_encoding_decl_file)
    lambda {
      reader.each do |product|
      end
    }.should raise_error(Nokogiri::XML::SyntaxError)
  end

  it "should transparently convert an iso-8859-1 file to utf-8 when there's no declaration but the user manually specifies iso-8859-1" do
    reader = ONIX::Reader.new(@no_encoding_decl_file, :encoding => "iso-8859-1")
    reader.each do |product|
      if RUBY_VERSION >= "1.9"
        utf8 = Encoding.find("utf-8")
        product.contributors[0].person_name_inverted.encoding.should eql(utf8)
      end

      product.contributors[0].person_name_inverted.should eql("Melo,Patr¡cia")
    end
  end

  it "should transparently convert a utf-16 file to utf-8" do
    reader = ONIX::Reader.new(@utf_16_file)
    product = nil
    reader.each do |p|
      product = p
    end

    # ROXML appears to munge the string encodings
    if RUBY_VERSION >= "1.9"
      utf8 = Encoding.find("utf-8")
      product.contributors[0].person_name_inverted.encoding.should eql(utf8)
    end

    product.contributors[0].person_name_inverted.should eql("Küng, Hans")
  end

  it "should support returning an APAProduct using deprecated API" do
    reader = ONIX::Reader.new(@file1, ONIX::APAProduct)
    reader.each do |product|
      product.should be_a_kind_of(ONIX::APAProduct)
    end
  end

  it "should support returning an APAProduct using new API" do
    reader = ONIX::Reader.new(@file1, :product_class => ONIX::APAProduct)
    reader.each do |product|
      product.should be_a_kind_of(ONIX::APAProduct)
    end
  end
end
