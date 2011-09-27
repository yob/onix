# coding: utf-8

class ONIX::SupplyDetail < ONIX::Element
  xml_name "SupplyDetail"
  xml_accessor :supplier_ean_location_number, :from => "SupplierEANLocationNumber"
  xml_accessor :supplier_san, :from => "SupplierSAN"
  onix_composite :supplier_identifiers, ONIX::SupplierIdentifier
  xml_accessor :supplier_name, :from => "SupplierName"
  xml_accessor :telephone_number, :from => "TelephoneNumber"
  xml_accessor :fax_number, :from => "FaxNumber"
  xml_accessor :email_address, :from => "EmailAddress"
  onix_composite :websites, ONIX::Website
  onix_code_from_list :supplier_role, "SupplierRole", :list => 93

  # FIXME: supply_to_country should be repeatable, and both these attributes
  # should be validated against lists 91 and 49 respectively
  onix_space_separated_list :supply_to_country, "SupplyToCountry"
  onix_space_separated_list :supply_to_territory, "SupplyToTerritory"
  onix_space_separated_list :supply_to_country_excluded, "SupplyToCountryExcluded"

  xml_accessor :supply_restriction_detail, :from => "SupplyRestrictionDetail"
  onix_code_from_list :returns_code_type, "ReturnsCodeType", :list => 53
  xml_accessor :returns_code, :from => "ReturnsCode"
  onix_date_accessor :last_date_for_returns, "LastDateForReturns"
  onix_code_from_list :availability_code, "AvailabilityCode", :list => 54
  onix_code_from_list :product_availability, "ProductAvailability", :list => 65
  onix_composite :new_supplier, ONIX::NewSupplier, :singular => true
  onix_code_from_list :date_format, "DateFormat", :list => 55
  xml_accessor :expected_ship_date, :from => "ExpectedShipDate"
  onix_date_accessor :on_sale_date, "OnSaleDate"
  xml_accessor :order_time, :from => "OrderTime", :as => Fixnum
  onix_composite :stocks, ONIX::Stock
  xml_accessor :pack_quantity, :from => "PackQuantity", :as => Fixnum
  onix_code_from_list :audience_restriction_flag, "AudienceRestrictionFlag", :list => 56
  xml_accessor :audience_restriction_note, :from => "AudienceRestrictionNote"
  onix_code_from_list :unpriced_item_type, "UnpricedItemType", :list => 57
  onix_composite :prices, ONIX::Price
  onix_composite :reissue, ONIX::Reissue, :singular => true
end
