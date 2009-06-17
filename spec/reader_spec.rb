# coding: utf-8

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')

require 'onix'

context "ONIX::Reader" do

  before(:each) do
    data_path = File.join(File.dirname(__FILE__),"..","data")
    @file1    = File.join(data_path, "9780194351898.xml")
    @file2    = File.join(data_path, "two_products.xml")
    @long_file   = File.join(data_path, "Bookwise_July_2008.xml")
    @entity_file = File.join(data_path, "entities.xml")
    @utf_16_file = File.join(data_path, "utf_16.xml")
    @iso_8859_1_file = File.join(data_path, "iso_8859_1.xml")
  end

  specify "should initialize with a filename" do
    reader = ONIX::Reader.new(@file1)
    reader.instance_variable_get("@reader").should be_a_kind_of(LibXML::XML::Reader)
  end

  specify "should initialize with an IO object" do
    File.open(@file1,"rb") do |f|
      reader = ONIX::Reader.new(f)
      reader.instance_variable_get("@reader").should be_a_kind_of(LibXML::XML::Reader)
    end
  end

  # This is commented out as the code that I was using to read the ONIX version from the
  # input was causing segfaults and other stability issues
  specify "should provide access to various XML metadata from file"
  #do
  #  reader = ONIX::Reader.new(@file1)
  #  reader.encoding.should eql("utf-8")
  #  reader.xml_lang.should eql(nil)
  #  reader.xml_version.should eql(1.0)
  #  reader.version.should eql([2,1,0])
  #end

  specify "should provide access to the header in an ONIX file" do
    reader = ONIX::Reader.new(@file1)
    reader.header.should be_a_kind_of(ONIX::Header)
  end

  specify "should iterate over all product records in an ONIX file" do
    reader = ONIX::Reader.new(@file1)
    counter = 0
    reader.each do |product|
      product.should be_a_kind_of(ONIX::Product)
      counter += 1
    end

    counter.should eql(1)
  end

  specify "should iterate over all product records in an ONIX file" do
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
  specify "should correctly parse a file that has an entity in it" do
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
  specify "should correctly parse a file with more than 7 records in in" do
    reader = ONIX::Reader.new(@long_file)
    counter = 0
    reader.each do |product|
      counter += 1
    end

    counter.should eql(346)
  end

  specify "should transparently convert a iso-8859-1 file to utf-8" do
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

  specify "should transparently convert a utf-16 file to utf-8" do
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
end
