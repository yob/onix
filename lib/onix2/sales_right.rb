module ONIX2
  class SalesRight
    include Virtus.model

    attribute :sales_rights_type
    attribute :rights_country
    attribute :rights_territory

    def to_xml
      SalesRightRepresenter.new(self).to_xml
    end

    def self.from_xml(data)
      SalesRightRepresenter.new(self.new).from_xml(data)
    end
  end

  class SalesRightRepresenter < Representable::Decorator
    include Representable::XML

    self.representation_wrap = :SalesRight

    property :sales_rights_type, as: "SalesRightsType"
    property :rights_country, as: "RightsCountry"
    property :rights_territory, as: "RightsTerritory"
  end
end

