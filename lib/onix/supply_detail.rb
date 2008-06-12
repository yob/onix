module ONIX
  class SupplyDetail
    include XML::Mapping

    text_node    :supplier_ean_location_number, "SupplierEANLocationNumber", :optional => true
    text_node    :supplier_san,        "SupplierSAN", :optional => true
    text_node    :supplier_name,       "SupplierName", :optional => true
    text_node    :telephone_number,    "TelephoneNumber", :optional => true
    text_node    :fax_number,          "FaxNumber", :optional => true
    text_node    :email_address,       "EmailAddress", :optional => true
    array_node   :websites,            "Website",           :class => ONIX::Website
    numeric_node :supplier_role,       "SupplierRole", :optional => true
    text_node    :supply_to_country,   "SupplyToCountry", :optional => true
    text_node    :supply_to_territory, "SupplyToTerritory", :optional => true
    text_node    :availability_status_code, "AvailabilityStatusCode", :optional => true
    text_node    :product_availability, "ProductAvailability", :optional => true
    object_node  :stock,               "Stock", :class => ONIX::Stock, :optional => true
    object_node  :price,               "Price", :class => ONIX::Price, :optional => true
  end
end
