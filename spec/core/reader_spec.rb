# coding: utf-8

require 'spec_helper.rb'

describe ONIX::Reader do

  before(:each) do
    @file1 = find_data_file("9780194351898.xml")
    @file2 = find_data_file("two_products.xml")
    @long_file = find_data_file("Bookwise_July_2008.xml")
    @entity_file = find_data_file("entities.xml")
    @utf_16_file = find_data_file("utf_16.xml")
    @iso_8859_1_file = find_data_file("iso_8859_1.xml")
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
    filename = find_data_file("reference_with_release_attrib.xml")
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

  it "should be rewindable" do
    reader = ONIX::Reader.new(@file1)
    product_arrays = [[],[],[]]

    # On the first loop, products are found.
    reader.each { |p| product_arrays[0] << p }
    product_arrays[0].size.should eql(1)

    # On the second loop, no products are found because parser is at end of file.
    reader.each { |p| product_arrays[1] << p }
    product_arrays[1].size.should eql(0)

    # But after rewinding, it should find the products again.
    reader.rewind
    reader.each { |p| product_arrays[2] << p }
    product_arrays[2].size.should eql(1)
  end

  it "should provide all products as an array" do
    reader = ONIX::Reader.new(@file2)
    reader.products.size.should eql(2)
    # Test this again to make sure it's memoized.
    reader.products.size.should eql(2)
  end

end
