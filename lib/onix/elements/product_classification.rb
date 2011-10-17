# coding: utf-8

class ONIX::ProductClassification < ONIX::Element
  xml_name "ProductClassification"
  xml_accessor :product_classification_type, "ProductClassificationType"
  onix_code_from_list :product_classification_code, "ProductClassificationCode", :list => 9
  xml_accessor :percent, :from => "Percent", :as => Float
end
