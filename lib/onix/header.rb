module ONIX
  class Header
    include XML::Mapping

    root_element_name "Header"

    text_node :from_company, "FromCompany"
    text_node :from_person,  "FromPerson"
  end
end
