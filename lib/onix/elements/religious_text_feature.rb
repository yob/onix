# coding: utf-8

class ONIX::ReligiousTextFeature < ONIX::Element
  xml_name "ReligiousTextFeature"
  onix_code_from_list :religious_text_feature_type, "ReligiousTextFeatureType", :list => 89
  onix_code_from_list :religious_text_feature_code, "ReligiousTextFeatureCode", :list => 90
  xml_accessor :religious_text_feature_description, :from => "ReligiousTextFeatureDescription"
end
