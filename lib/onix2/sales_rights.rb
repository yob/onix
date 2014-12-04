module ONIX2
  class SalesRights
    include Virtus.model

    attribute :sales_rights_type
    attribute :rights_country
    attribute :rights_territory

    def to_xml
      SalesRightsRepresenter.new(self).to_xml
    end

    def self.from_xml(data)
      SalesRightsRepresenter.new(self.new).from_xml(data)
    end
  end

  class SalesRightsRepresenter < Representable::Decorator
    include Representable::XML

    self.representation_wrap = :SalesRights

    property :sales_rights_type, as: "SalesRightsType"
    property :rights_country, as: "RightsCountry"
    property :rights_territory, as: "RightsTerritory"
  end
end

