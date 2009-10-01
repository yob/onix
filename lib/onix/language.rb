# coding: utf-8

module ONIX
  class Language
    include ROXML
    include ONIX::Common

    xml_name "Language"

    xml_accessor :language_role,        :from => "LanguageRole", :as => Fixnum, :to_xml => ONIX::Formatters.two_digit
    xml_accessor :language_code,        :from => "LanguageCode"
    xml_accessor :country_code,         :from => "CountryCode"
  end
end
