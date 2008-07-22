module ONIX
  class SupplyDetail
    include XML::Mapping

    text_node    :supplier_ean_location_number, "SupplierEANLocationNumber", :optional => true
    text_node    :supplier_san,        "SupplierSAN", :optional => true
    text_node    :supplier_name,       "SupplierName", :optional => true
    text_node    :telephone_number,    "TelephoneNumber", :optional => true
    text_node    :fax_number,          "FaxNumber", :optional => true
    text_node    :email_address,       "EmailAddress", :optional => true
    array_node   :websites,            "Website", :class => ONIX::Website, :optional => true
    two_digit_node :supplier_role,       "SupplierRole", :optional => true
    text_node    :supply_to_country,   "SupplyToCountry", :optional => true
    text_node    :supply_to_territory, "SupplyToTerritory", :optional => true
    text_node    :availability_status_code, "AvailabilityStatusCode", :optional => true
    two_digit_node :product_availability, "ProductAvailability", :optional => true
    array_node   :stock,               "Stock", :class => ONIX::Stock, :optional => true
    array_node   :prices,              "Price", :class => ONIX::Price, :optional => true

    def initialize
      # setup some default values for when the object is created from scratch
      self.websites = []
      self.stock = []
      self.prices = []
    end
  end
end
