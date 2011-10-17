# coding: utf-8

# See also: NotForSale. It's possible to set not for sale here as well.
#
class ONIX::SalesRights < ONIX::Element
  xml_name "SalesRights"
  onix_code_from_list :sales_rights_type, "SalesRightsType", :list => 46
  onix_spaced_codes_from_list :rights_countries, "RightsCountry", :list => 91
  onix_spaced_codes_from_list :rights_territories, "RightsTerritory", :list => 49

  # Deprecated accessors
  onix_codes_from_list :rights_region, "RightsRegion", :list => 47
end
