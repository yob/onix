module ONIX
  class SalesRestriction
    include ROXML

    xml_accessor :sales_restriction_type, :from =>"SalesRestrictionType", :as => Fixnum # should be a 2 digit num
  end
end
