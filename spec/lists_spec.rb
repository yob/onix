# coding: utf-8

require File.dirname(__FILE__) + '/spec_helper.rb'

context ONIX::Lists, "list method" do

  it "should return a hash containing the ProductForm code list" do
    forms = ONIX::Lists.list(7)
    forms.should be_a(Hash)
    forms["BB"].should eql("Hardback")
  end

end

context ONIX::Lists, "product_form shortcut method" do

  it "should return a hash containing the ProductForm code list" do
    forms = ONIX::Lists.product_form
    forms.should be_a(Hash)
    forms["BB"].should eql("Hardback")
  end

end

context ONIX::Lists, "PRODUCT_FORM shortcut constant" do

  it "should return a hash containing the ProductForm code list" do
    forms = ONIX::Lists::PRODUCT_FORM
    forms.should be_a(Hash)
    forms["BB"].should eql("Hardback")
  end

end
