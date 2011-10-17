# coding: utf-8

class ONIX::PersonDate < ONIX::Element
  xml_name "PersonDate"
  onix_code_from_list :person_date_role, "PersonDateRole", :list => 75
  onix_code_from_list :date_format, "DateFormat", :list => 55
  xml_accessor :date, :from => "Date"
end
