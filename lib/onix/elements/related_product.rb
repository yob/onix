# coding: utf-8

class ONIX::RelatedProduct < ONIX::ProductBase
  xml_name "RelatedProduct"
  onix_code_from_list :relation_code, "RelationCode", :list => 51
end
