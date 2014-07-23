# coding: utf-8

require "rubygems"
require "bundler"
Bundler.setup

require 'date'
require 'stringio'
require 'rubygems'
require 'onix'
require 'rspec/given'

def load_xml(file)
  File.read(File.join(File.dirname(__FILE__), "..", "data", file))
end
