# coding: utf-8

module ONIX2
  class Publisher
    include Virtus.model

    attribute :publishing_role, Integer
    attribute :name_code_type, Integer
    attribute :name_code_type_name
    attribute :name_code_type_value
    attribute :publisher_name

    def to_xml
      PublisherRepresenter.new(self).to_xml
    end

    def self.from_xml(data)
      PublisherRepresenter.new(self.new).from_xml(data)
    end
  end

  class PublisherRepresenter < Representable::Decorator
    include Representable::XML

    self.representation_wrap = :Publisher

    property :publishing_role, as: "PublishingRole", render_filter: ::ONIX2::Formatters::TWO_DIGITS
    property :name_code_type, as: "NameCodeType", render_filter: ::ONIX2::Formatters::TWO_DIGITS
    property :name_code_type_name, as: "NameCodeTypeName"
    property :name_code_type_value, as: "NameCodeTypeValue"
    property :publisher_name, as: "PublisherName"
  end
end
