# coding: utf-8

module ONIX
  class AddresseeIdentifier
    include Virtus.model

    attribute :addressee_id_type, Integer
    attribute :id_type_name
    attribute :id_value

    def to_xml
      AddresseeIdentifierRepresenter.new(self).to_xml
    end

    def self.from_xml(data)
      AddresseeIdentifierRepresenter.new(self.new).from_xml(data)
    end
  end

  class AddresseeIdentifierRepresenter < Representable::Decorator
    include Representable::XML

    self.representation_wrap = :AddresseeIdentifier

    property :addressee_id_type, as: "AddresseeIDType", render_filter: ::ONIX::Formatters::TWO_DIGITS
    property :id_type_name, as: "IDTypeName"
    property :id_value, as: "IDValue"
  end
end
