# coding: utf-8

class ONIX::NewSupplier < ONIX::Element
  xml_name "NewSupplier"
  xml_accessor :supplier_ean_location_number, :from => "SupplierEANLocationNumber"
  xml_accessor :supplier_san, :from => "SupplierSAN"
  onix_composite :supplier_identifiers, ONIX::SupplierIdentifier
  xml_accessor :supplier_name, :from => "SupplierName"
  xml_accessor :telephone_number, :from => "TelephoneNumber"
  xml_accessor :fax_number, :from => "FaxNumber"
  xml_accessor :email_address, :from => "EmailAddress"
end
