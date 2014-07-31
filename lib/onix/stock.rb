# coding: utf-8

module ONIX
  class Stock
    include Virtus.model

    # NOTE: these *should* be numeric fields according to the spec,
    #       but heaps of ONIX files in the wild use text
    attribute :on_hand
    attribute :on_order

    def to_xml
      StockRepresenter.new(self).to_xml
    end

    def self.from_xml(data)
      StockRepresenter.new(self.new).from_xml(data)
    end
  end

  class StockRepresenter < Representable::Decorator
    include Representable::XML

    self.representation_wrap = :Stock

    property :on_hand, as: "OnHand"
    property :on_order, as: "OnOrder"
  end
end
