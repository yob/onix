# coding: utf-8

class ONIX::StockQuantityCoded < ONIX::Element
  xml_name "StockQuantityCoded"
  onix_code_from_list :stock_quantity_code_type, "StockQuantityCodeType", :list => 70
  xml_accessor :stock_quantity_code_type_name, :from => "StockQuantityCodeTypeName"
  xml_accessor :stock_quantity_code
end
