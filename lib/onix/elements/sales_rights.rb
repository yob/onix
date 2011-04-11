# coding: utf-8

module ONIX

  # See also: NotForSale. It's possible to set not for sale here as well.
  #
  class SalesRights < ONIX::Element

    xml_name "SalesRights"
    onix_code_from_list(:sales_rights_type, "SalesRightsType", :list => 46)
    onix_space_separated_list(:rights_countries, "RightsCountry")
    onix_space_separated_list(:rights_territories, "RightsTerritory")

    # Deprecated accessors
    xml_accessor(:rights_region, :from => "RightsRegion", :as => [])

  end
end
