# coding: utf-8

class ONIX::ProductFormFeature < ONIX::Element
  xml_name "ProductFormFeature"
  onix_code_from_list :product_form_feature_type, "ProductFormFeatureType", :list => 79
  xml_accessor :product_form_feature_value, :from => "ProductFormFeatureValue"
  xml_accessor :product_form_feature_description, :from => "ProductFormFeatureDescription"
end
