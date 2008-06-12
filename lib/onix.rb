require 'rubygems'
require 'xml/mapping'

# core files
require File.join(File.dirname(__FILE__), "onix", "sender_identifier")
require File.join(File.dirname(__FILE__), "onix", "addressee_identifier")
require File.join(File.dirname(__FILE__), "onix", "header")
require File.join(File.dirname(__FILE__), "onix", "product_identifier")
require File.join(File.dirname(__FILE__), "onix", "title")
require File.join(File.dirname(__FILE__), "onix", "website")
require File.join(File.dirname(__FILE__), "onix", "contributor")
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
    Minor = 1
    Tiny  = 0
    
    String = [Major, Minor, Tiny].join('.')
  end
end
