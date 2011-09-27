# coding: utf-8

class ONIX::Prize < ONIX::Element
  xml_name "Prize"
  xml_accessor :prize_name, :from => "PrizeName"
  xml_accessor :prize_year, :from => "PrizeYear"
  onix_code_from_list :prize_country, "PrizeCountry", :list => 91
  onix_code_from_list :prize_code, "PrizeCode", :list => 41
  xml_accessor :prize_jury, :from => "PrizeJury"
end
