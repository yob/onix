require 'forwardable'

module ONIX
  # super class for some simplified ONIX::Product wrappers
  class SimpleProduct

    def initialize(product = nil)
      @product = product || ::ONIX::Product.new
    end

    class << self
      
      include Forwardable

      def load_from_file(filename)
        self.new(::ONIX::Product.load_from_file(filename))
      end

      def load_from_xml(xml)
        self.new(::ONIX::Product.load_from_xml(xml))
      end
    
      protected

      def delegate(*args)
        def_delegators :@product, *args
      end
    end

    def product
      @product
    end

    def fill_into_xml(xml)
      product.fill_into_xml(xml)
    end

    def save_to_xml
      product.save_to_xml
    end

    # TODO: add method missing magic to proxy through to the underlying product?

  end
end
