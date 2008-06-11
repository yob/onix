require 'rubygems'
require 'xml/mapping'

require File.join(File.dirname(__FILE__), "onix", "header")
require File.join(File.dirname(__FILE__), "onix", "product_identifier")
require File.join(File.dirname(__FILE__), "onix", "title")
require File.join(File.dirname(__FILE__), "onix", "product")
require File.join(File.dirname(__FILE__), "onix", "message")
require File.join(File.dirname(__FILE__), "onix", "stream_reader")
require File.join(File.dirname(__FILE__), "onix", "stream_writer")

module ONIX
  module Version #:nodoc:
    Major = 0
    Minor = 0
    Tiny  = 1
    
    String = [Major, Minor, Tiny].join('.')
  end
end
