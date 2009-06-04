# coding: utf-8

module ONIX
  class Stock
    include ROXML
    include ONIX::Common

    xml_name "Stock"

    # NOTE: these *should* be numeric fields according to the spec,
    #       but heaps of ONIX files in the wild use text
    xml_accessor :on_hand, :from => "OnHand"
    xml_accessor :on_order, :from => "OnOrder"
  end
end
