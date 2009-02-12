module ONIX
  class ProductIdentifier
    include ROXML

    xml_accessor :product_id_type, :from => "ProductIDType", :as => Integer # should be a 2 digit num
    xml_accessor :id_value, :from => "IDValue"
  end
end
