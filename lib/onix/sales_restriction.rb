module ONIX
  class SalesRestriction
    include XML::Mapping

    numeric_node :sales_restriction_type, "SalesRestrictionType"
  end
end
