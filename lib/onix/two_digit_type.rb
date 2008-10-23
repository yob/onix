
module ONIX

  # Internal class representing 2-digit XML content
  #
  # In context:
  #  <element attribute="XMLAttributeRef">
  #   XMLTwoDigitRef
  #  </element>
  class TwoDigitType < ROXML::XMLRef # ::nodoc::
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
      value = value.to_i
      if value < 10
        value = "0#{value}"
      elsif value < 100
        value = value.to_s
      else
        value = "00"
      end
      add(parent.child_add(LibXML::XML::Node.new_element(name)), value)
      xml
    end

    def value(xml)
      val = xml.content.to_i
      block ? block.call(val) : val
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

ROXML::TypeRegistry.register(:twodigit, ONIX::TwoDigitType)
