module ONIX
  class Stock
    include XML::Mapping

    # TODO: these *should* be numeric fields according to the spec,
    #       but heaps of ONIX files in the wild use text
    text_node :on_hand,   "OnHand", :optional => true
    text_node :on_order,  "OnOrder", :optional => true
  end
end
