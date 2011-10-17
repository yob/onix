# coding: utf-8

class ONIX::Language < ONIX::Element
  xml_name "Language"
  onix_code_from_list :language_role, "LanguageRole", :list => 22
  onix_code_from_list :language_code, "LanguageCode", :list => 74
  onix_code_from_list :country_code, "CountryCode", :list => 91
end
