module ONIX
  class SupplyDetail
    include ROXML

    xml_accessor :supplier_ean_location_number, :from => "SupplierEANLocationNumber"
    xml_accessor :supplier_san, :from => "SupplierSAN"
    xml_accessor :supplier_name, :from => "SupplierName"
    xml_accessor :telephone_number, :from => "TelephoneNumber"
    xml_accessor :fax_number, :from => "FaxNumber"
    xml_accessor :email_address, :from => "EmailAddress"
    xml_accessor :websites, [ONIX::Website], :from => "Website"
    xml_accessor :supplier_role, :from => "SupplierRole", :as => Integer # should be a 2 digit num
    xml_accessor :supply_to_country, :from => "SupplyToCountry"
    xml_accessor :supply_to_territory, :from => "SupplyToTerritory"
    xml_accessor :availability_status_code, :from => "AvailabilityStatusCode", :as => Integer # should be a 2 digit num
    xml_accessor :product_availability, :from => "ProductAvailability", :as => Integer # should be a 2 digit num
    xml_accessor :stock, [ONIX::Stock], :from => "Stock"
    xml_accessor :prices, [ONIX::Price], :from => "Price"

  end
end
