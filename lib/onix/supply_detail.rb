# coding: utf-8

module ONIX
  class SupplyDetail
    include ROXML

    xml_name "SupplyDetail"

    xml_accessor :supplier_ean_location_number, :from => "SupplierEANLocationNumber"
    xml_accessor :supplier_san, :from => "SupplierSAN"
    xml_accessor :supplier_name, :from => "SupplierName"
    xml_accessor :telephone_number, :from => "TelephoneNumber"
    xml_accessor :fax_number, :from => "FaxNumber"
    xml_accessor :email_address, :from => "EmailAddress"
    xml_accessor :websites, :from => "Website", :as => [ONIX::Website]
    xml_accessor :supplier_role, :from => "SupplierRole", :as => Fixnum, :to_xml => ONIX::Formatters.two_digit
    xml_accessor :supply_to_country, :from => "SupplyToCountry"
    xml_accessor :supply_to_territory, :from => "SupplyToTerritory"
    xml_accessor :availability_status_code, :from => "AvailabilityStatusCode", :as => Fixnum, :to_xml => ONIX::Formatters.two_digit
    xml_accessor :product_availability, :from => "ProductAvailability", :as => Fixnum, :to_xml => ONIX::Formatters.two_digit
    xml_accessor :stock, :from => "Stock", :as => [ONIX::Stock]
    xml_accessor :prices, :from => "Price", :as => [ONIX::Price]

    def initialize
      self.websites = []
      self.stock = []
      self.prices = []
    end
  end
end
