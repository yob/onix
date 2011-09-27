# coding: utf-8

class ONIX::SupplierIdentifier < ONIX::Identifier
  xml_name "SupplierIdentifier"
  onix_code_from_list :supplier_id_type, "SupplierIDType", :list => 92
end
