# coding: utf-8

module ONIX

  # See also: SalesRights. ONIX 2.1 prefers NotForSale blocks if a product is
  # not for sale, but this can also be specified with SalesRightsType in
  # SalesRights.
  #
  class NotForSale < ONIX::Element

    xml_name "NotForSale"
    onix_space_separated_list(:rights_countries, "RightsCountry")
    onix_space_separated_list(:rights_territories, "RightsTerritory")
    xml_accessor(:product_identifiers, :from => "ProductIdentifier", :as => [ONIX::ProductIdentifier])
    xml_accessor(:publisher_name, :from => "PublisherName")

  end

end
