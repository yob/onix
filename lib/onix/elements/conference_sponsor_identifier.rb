# coding: utf-8

class ONIX::ConferenceSponsorIdentifier < ONIX::Identifier
  xml_name "ConferenceSponsorIdentifier"
  onix_code_from_list :conference_sponsor_id_type, "ConferenceSponsorIDType", :list => 44
end
