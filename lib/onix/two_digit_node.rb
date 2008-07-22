class TwoDigitNode < XML::Mapping::SingleAttributeNode
  def initialize_impl(path)
    @path = XML::XXPath.new(path)
  end

  def extract_attr_value(xml)
    txt = default_when_xpath_err{ @path.first(xml).text }
    begin
      Integer(txt)
    rescue ArgumentError
      Float(txt)
    end
  end

  def set_attr_value(xml, value)
    raise ArgumentError, "Not an integer: #{value}" unless Numeric===value
    raise ArgumentError, "value cannot be > 99" if value > 99
    str = value.to_s
    str = "0#{str}" if str.size == 1
    @path.first(xml,:ensure_created=>true).text = str
  end
end

XML::Mapping.add_node_class TwoDigitNode
