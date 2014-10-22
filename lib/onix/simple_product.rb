# coding: utf-8

require 'forwardable'

module ONIX2
  # super class for some simplified ONIX2::Product wrappers
  class SimpleProduct

    def initialize(product = nil)
      @product = product || ::ONIX2::Product.new
    end

    class << self

      include Forwardable

      def from_xml(xml)
        self.new(::ONIX2::Product.from_xml(xml))
      end

      def parse_file(filename)
        self.new(::ONIX2::Product.parse(File.read(filename)))
      end

      def parse(xml)
        self.new(::ONIX2::Product.parse(xml))
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

    # TODO: add method missing magic to proxy through to the underlying product?

  end
end
