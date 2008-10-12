module ONIX
  class SalesRestriction
    include ROXML

    xml_accessor :sales_restriction_type, :from =>"SalesRestrictionType"
  end
end
