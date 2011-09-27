# coding: utf-8

class ONIX::BatchBonus < ONIX::Element
  xml_name "BatchBonus"
  xml_accessor :batch_quantity, :from => "BatchQuantity", :as => Fixnum
  xml_accessor :free_quantity, :from => "FreeQuantity", :as => Fixnum
end
