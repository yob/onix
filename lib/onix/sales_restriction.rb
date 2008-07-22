module ONIX
  class SalesRestriction
    include XML::Mapping

    two_digit_node :sales_restriction_type, "SalesRestrictionType"
  end
end
