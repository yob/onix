# coding: utf-8

class ONIX::CopyrightOwnerIdentifier < ONIX::Identifier
  xml_name "CopyrightOwnerIdentifier"
  onix_code_from_list :copyright_owner_id_type, "CopyrightOwnerIDType", :list => 44
end
