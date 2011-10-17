# coding: utf-8

# This is the abstract base class of Product, RelatedProduct
# and ContainedItem.
#
class ONIX::ProductBase < ONIX::Element
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

  # Extend this product instance with a module. Typically these modules
  # make it easier to read or write common values in the Product.
  #
  # The product tracks the modules that have extended it, so that it
  # can easily pass these extensions on to other products
  # (see #interpret_like_me).
  #
  # For convenience, this method returns the product itself.
  #
  def interpret(mods)
    @_extensions ||= []
    [mods].flatten.compact.uniq.each { |mod|
      next  if @_extensions.include?(mod)
      @_extensions << mod
      extend(mod)
    }
    self
  end

  # Apply all the modules that have extended this product to another product.
  #
  # This is useful when, say, accessing RelatedProduct or ContainedItem
  # composites. Your module might do something like:
  #
  #   def print_product
  #     prod = related_products.detect { |p| p.relation_code == 13 }
  #     prod ? interpret_like_me(prod) : nil
  #   end
  #
  # As a result, this related product will have all the extensions applied
  # to this product.
  #
  def interpret_like_me(product)
    product.interpret(@_extensions)
  end

end
