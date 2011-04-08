# coding: utf-8

require "rubygems"
require "bundler"
Bundler.setup

require 'date'
require 'stringio'
require 'rubygems'
require 'onix'


module ONIX::SpecHelpers

  def load_doc_and_root(subpath)
    data_path = File.join(File.dirname(__FILE__), '..', 'data')
    file1 = File.join(data_path, subpath)
    @doc = Nokogiri::XML::Document.parse(File.read(file1))
    @root = @doc.root
  end

end

include ONIX::SpecHelpers


RSpec::Matchers.define(:produce_the_tag) do |expected|
  match do |actual|
    actual.to_xml.to_s[0, expected.size] == expected
  end
end

RSpec::Matchers.define(:include_the_xml) do |expected|
  match do |actual|
    actual.to_xml.to_s.include?(expected)
  end

  failure_message_for_should do |actual|
    "expected '#{actual.to_xml.to_s}' to include the xml '#{expected}'"
  end

  failure_message_for_should_not do |actual|
    "expected '#{actual.to_xml.to_s}' not to include the xml '#{expected}'"
  end
end
