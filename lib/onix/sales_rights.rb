# coding: utf-8

module ONIX

  # See also: NotForSale. It's possible to set not for sale here as well.
  #
  class SalesRights
    include ROXML

    xml_name "SalesRights"
    xml_accessor :sales_rights_type, :from => "SalesRightsType", :as => Fixnum, :to_xml => ONIX::Formatters.two_digit
    xml_accessor(:rights_countries, :from => "RightsCountry", :to_xml => ONIX::Formatters.space_separated) { |v| v.split  if v }
    xml_accessor(:rights_territories, :from => "RightsTerritory", :to_xml => ONIX::Formatters.space_separated) { |v| v.split  if v }

    # Deprecated accessors
    xml_accessor(:rights_region, :from => "RightsRegion", :as => [])

  end
end
