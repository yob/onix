require 'bigdecimal'

module ONIX

  class DecimalType < ROXML::XMLRef # ::nodoc::
    attr_reader :cdata, :content

    def initialize(accessor, args, &block)
      super(accessor, args, &block)
      @content = args.content?
      @cdata = args.cdata?
    end

    # Updates the text in the given _xml_ block to
    # the _value_ provided.
    def update_xml(xml, value)
      parent = wrap(xml)
      if value.kind_of?(BigDecimal)
        value = value.to_s("F")
      else
        value = value.to_s
      end
      add(parent.child_add(LibXML::XML::Node.new_element(name)), value)
      xml
    end

    def value(xml)
      if content
        value = BigDecimal.new(xml.content)
      else
        child = xml.search(name).first
        value = BigDecimal.new(child.content) if child
      end
      block ? block.call(value) : value
    end

    private

    def add(dest, value)
      if cdata
        dest.child_add(LibXML::XML::Node.new_cdata(value.to_utf))
      else
        dest.content = value.to_utf
      end
    end
  end
end

ROXML::TypeRegistry.register(:decimal, ONIX::DecimalType)
