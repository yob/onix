module ONIX
  class ProductIdentifier
    include ROXML

    xml_accessor :product_id_type, :twodigit, :from => "ProductIDType"
    xml_accessor :id_value, :from => "IDValue"
  end
end
