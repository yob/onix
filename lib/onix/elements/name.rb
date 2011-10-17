# coding: utf-8

class ONIX::Name < ONIX::NameBase
  xml_name "Name"
  onix_code_from_list :person_name_type, "PersonNameType", :list => 18
end
