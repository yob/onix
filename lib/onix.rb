require 'rubygems'
gem 'xml-mapping', '0.8.1'
require 'xml/mapping'

# custom xml-mapping node types
require File.join(File.dirname(__FILE__), "onix", "two_digit_node")
require File.join(File.dirname(__FILE__), "onix", "date_node")

# core files
# - ordering is important, classes need to be defined before any
#   other class can use them
require File.join(File.dirname(__FILE__), "onix", "sender_identifier")
require File.join(File.dirname(__FILE__), "onix", "addressee_identifier")
require File.join(File.dirname(__FILE__), "onix", "header")
require File.join(File.dirname(__FILE__), "onix", "product_identifier")
require File.join(File.dirname(__FILE__), "onix", "title")
require File.join(File.dirname(__FILE__), "onix", "website")
require File.join(File.dirname(__FILE__), "onix", "contributor")
require File.join(File.dirname(__FILE__), "onix", "subject")
require File.join(File.dirname(__FILE__), "onix", "other_text")
require File.join(File.dirname(__FILE__), "onix", "media_file")
require File.join(File.dirname(__FILE__), "onix", "imprint")
require File.join(File.dirname(__FILE__), "onix", "publisher")
require File.join(File.dirname(__FILE__), "onix", "sales_restriction")
require File.join(File.dirname(__FILE__), "onix", "stock")
require File.join(File.dirname(__FILE__), "onix", "price")
require File.join(File.dirname(__FILE__), "onix", "supply_detail")
require File.join(File.dirname(__FILE__), "onix", "product")
require File.join(File.dirname(__FILE__), "onix", "message")
require File.join(File.dirname(__FILE__), "onix", "stream_reader")
require File.join(File.dirname(__FILE__), "onix", "stream_writer")

# product wrappers
require File.join(File.dirname(__FILE__), "onix", "simple_product")
require File.join(File.dirname(__FILE__), "onix", "apa_product")

module ONIX
  module Version #:nodoc:
    Major = 0
    Minor = 2
    Tiny  = 3
    
    String = [Major, Minor, Tiny].join('.')
  end
end
