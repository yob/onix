# coding: utf-8

class ONIX::ReligiousText < ONIX::Element
  xml_name "ReligiousText"
  onix_composite :bible, ONIX::Bible, :singular => true
  onix_code_from_list :religious_text_identifier, "ReligiousTextIdentifier", :list => 88
  onix_composite :religious_text_feature, ONIX::ReligiousTextFeature
end
