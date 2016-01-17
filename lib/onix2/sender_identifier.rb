# coding: utf-8

module ONIX2
  class SenderIdentifier
    include Virtus.model

    attribute :sender_id_type, Integer
    attribute :id_type_name
    attribute :id_value

    def to_xml
      SenderIdentifierRepresenter.new(self).to_xml
    end

    def self.from_xml(data)
      SenderIdentifierRepresenter.new(self.new).from_xml(data)
    end
  end

  class SenderIdentifierRepresenter < Representable::Decorator
    include Representable::XML

    self.representation_wrap = :SenderIdentifier

    property :sender_id_type, as: "SenderIDType", render_filter: ::ONIX2::Formatters::TWO_DIGITS
    property :id_type_name, as: "IDTypeName"
    property :id_value, as: "IDValue"
  end
end
