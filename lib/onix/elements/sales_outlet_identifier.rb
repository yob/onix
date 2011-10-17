# coding: utf-8

class ONIX::SalesOutletIdentifier < ONIX::Identifier
  xml_name "SalesOutletIdentifier"
  onix_code_from_list :sales_outlet_id_type, "SalesOutletIDType", :list => 102
end
