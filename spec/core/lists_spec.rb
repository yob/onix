# coding: utf-8

require 'spec_helper.rb'

describe ONIX::Lists, "list method" do

  it "should return a hash containing the ProductForm code list" do
    forms = ONIX::Lists.list(7)
    forms.should be_a(Hash)
    forms["BB"].should eql("Hardback")
  end

end

describe ONIX::Lists, "product_form shortcut method" do

  it "should return a hash containing the ProductForm code list" do
    forms = ONIX::Lists.product_form
    forms.should be_a(Hash)
    forms["BB"].should eql("Hardback")
  end

end

describe ONIX::Lists, "PRODUCT_FORM shortcut constant" do

  it "should return a hash containing the ProductForm code list" do
    forms = ONIX::Lists::PRODUCT_FORM
    forms.should be_a(Hash)
    forms["BB"].should eql("Hardback")
  end

end
