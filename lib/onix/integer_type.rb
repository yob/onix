
module ONIX

  class IntegerType < ROXML::XMLRef # ::nodoc::
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
      add(parent.child_add(LibXML::XML::Node.new_element(name)), value)
      xml
    end

    def value(xml)
      if content
        value = xml.content.to_i
      else
        child = xml.search(name).first
        value = child.content.to_i if child
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

ROXML::TypeRegistry.register(:integer, ONIX::IntegerType)
