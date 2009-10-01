# coding: utf-8
# milkfarm
module ONIX
  module Lists
    # Code list 1
    NOTIFICATION_TYPE = {
      1 => "Early notification",
      2 => "Advance notification (confirmed)",
      3 => "Notification confirmed from book-in-hand",
      4 => "Update (partial)",
      5 => "Delete",
      8 => "Notice of sale",
      9 => "Notice of acquisition",
      12 => "Update - SupplyDetail only",
      13 => "Update - MarketRepresentation only",
      14 => "Update - SupplyDetail and MarketRepresentation",
    }
  end
end
