# coding: utf-8

require File.dirname(__FILE__) + '/spec_helper.rb'

describe ONIX2::Lists, "list method" do

  it "should return a hash containing the ProductForm code list" do
    forms = ONIX2::Lists.list(7)
    expect(forms).to be_a(Hash)
    expect(forms["BB"]).to be_eql("Hardback")
  end

end

describe ONIX2::Lists, "product_form shortcut method" do

  it "should return a hash containing the ProductForm code list" do
    forms = ONIX2::Lists.product_form
    expect(forms).to be_a(Hash)
    expect(forms["BB"]).to be_eql("Hardback")
  end

end

describe ONIX2::Lists, "PRODUCT_FORM shortcut constant" do

  it "should return a hash containing the ProductForm code list" do
    forms = ONIX2::Lists::PRODUCT_FORM
    expect(forms).to be_a(Hash)
    expect(forms["BB"]).to be_eql("Hardback")
  end

end
