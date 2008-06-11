module ONIX
  class Header
    include XML::Mapping

    text_node :from_company, "FromCompany"
    text_node :from_person,  "FromPerson"
  end
end
