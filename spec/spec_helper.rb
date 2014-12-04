# coding: utf-8

require "rubygems"
require "bundler/setup"

require "pry"
require 'date'
require 'stringio'
require 'rubygems'
require 'onix2'
require 'rspec/given'

def load_xml(file)
  File.read(File.join(File.dirname(__FILE__), "..", "data", file))
end
