require 'date'

class DateNode < XML::Mapping::SingleAttributeNode
  def initialize_impl(path)
    @path = XML::XXPath.new(path)
  end

  def extract_attr_value(xml)
    txt = default_when_xpath_err{ @path.first(xml).text }
    begin
      Date.parse(txt)
    rescue ArgumentError
      txt
    end
  end

  def set_attr_value(xml, value)
    unless value.kind_of?(Date) || value.kind_of?(DateTime) || value.kind_of?(Time)
      raise ArgumentError, "Not a date or time object: #{value}"
    end
    @path.first(xml,:ensure_created=>true).text = value.strftime("%Y%m%d")
  end
end

XML::Mapping.add_node_class DateNode
