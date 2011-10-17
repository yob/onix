# coding: utf-8

require 'forwardable'

module ONIX
  # super class for some simplified ONIX::Product wrappers
  class SimpleProduct

    def initialize(product = nil)
      @product = product || ::ONIX::Product.new
    end

    class << self

      include Forwardable

      def from_xml(xml)
        self.new(::ONIX::Product.from_xml(xml))
      end

      def parse_file(filename)
        self.new(::ONIX::Product.parse(File.read(filename)))
      end

      def parse(xml)
        self.new(::ONIX::Product.parse(xml))
      end

      protected

      def delegate(*args)
        def_delegators :@product, *args
      end
    end

    def product
      @product
    end

    def to_xml
      product.to_xml
    end

    delegate :interpret

    # TODO: add method missing magic to proxy through to the underlying product?

  end
end
