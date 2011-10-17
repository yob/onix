# coding: utf-8

# See also: SalesRights. ONIX 2.1 prefers NotForSale blocks if a product is
# not for sale, but this can also be specified with SalesRightsType in
# SalesRights.
#
class ONIX::NotForSale < ONIX::Element
  xml_name "NotForSale"
  onix_spaced_codes_from_list :rights_countries, "RightsCountry", :list => 91
  onix_spaced_codes_from_list :rights_territories, "RightsTerritory", :list => 49
  onix_composite :product_identifiers, ONIX::ProductIdentifier
  xml_accessor :publisher_name, :from => "PublisherName"
end
