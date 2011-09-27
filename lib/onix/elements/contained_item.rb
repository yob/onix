# coding: utf-8

class ONIX::ContainedItem < ONIX::ProductBase
  xml_name "ContainedItem"
  xml_accessor :item_quantity, :from => "ItemQuantity", :as => Fixnum
end
