# coding: utf-8

module ONIX

  # See also: SalesRights. ONIX 2.1 prefers NotForSale blocks if a product is
  # not for sale, but this can also be specified with SalesRightsType in
  # SalesRights.
  #
  class NotForSale

    include ROXML

    xml_name "NotForSale"
    xml_accessor(:rights_countries, :from => "RightsCountry", :to_xml => ONIX::Formatters.space_separated) { |v| v.split  if v }
    xml_accessor(:rights_territories, :from => "RightsTerritory", :to_xml => ONIX::Formatters.space_separated) { |v| v.split  if v }
    xml_accessor(:product_identifiers, :from => "ProductIdentifier", :as => [ONIX::ProductIdentifier])
    xml_accessor(:publisher_name, :from => "PublisherName")

  end

end
