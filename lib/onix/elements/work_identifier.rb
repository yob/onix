# coding: utf-8

class ONIX::WorkIdentifier < ONIX::Identifier
  xml_name "WorkIdentifier"
  onix_code_from_list :work_id_type, "WorkIDType", :list => 16
end
