# coding: utf-8

class ONIX::SalesOutlet < ONIX::Element
  xml_name "SalesOutlet"
  onix_composite :sales_outlet_identifier, ONIX::SalesOutletIdentifier
  xml_accessor :sales_outlet_name, :from => "SalesOutletName"
end
