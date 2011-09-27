# coding: utf-8

class ONIX::RelatedProduct < ONIX::Element
  xml_name "RelatedProduct"
  onix_code_from_list :relation_code, "RelationCode", :list => 51
  onix_composite :product_identifiers, ONIX::ProductIdentifier
  onix_composite :websites, ONIX::Website
  onix_code_from_list :product_form, "ProductForm", :list => 7
  onix_codes_from_list :product_form_details, "ProductFormDetail", :list => 78
  onix_composite :product_form_features, ONIX::ProductFormFeature
  onix_code_from_list :product_packaging, "ProductPackaging", :list => 80
  xml_accessor :product_form_description, :from => "ProductFormDescription"
  xml_accessor :number_of_pieces, :from => "NumberOfPieces", :as => Fixnum
  onix_code_from_list :trade_category, "TradeCategory", :list => 12
  onix_code_from_list :product_content_type, "ProductContentType", :list => 81
  onix_code_from_list :epub_type, "EpubType", :list => 10
  xml_accessor :epub_type_version, "EpubTypeVersion"
  xml_accessor :epub_type_description, "EpubTypeDescription"
  onix_code_from_list :epub_format, "EpubFormat", :list => 11
  xml_accessor :epub_format_version, "EpubFormatVersion"
  xml_accessor :epub_format_description, "EpubFormatDescription"
  xml_accessor :epub_type_note, "EpubTypeNote"
end
