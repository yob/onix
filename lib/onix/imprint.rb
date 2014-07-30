# coding: utf-8

module ONIX
  class Imprint
    include Virtus.model

    attribute :name_code_type, Integer
    attribute :name_code_type_name
    attribute :name_code_value
    attribute :imprint_name

    def to_xml(type = "reference")
      type == "reference" ? ImprintRepresenter.new(self).to_xml : ImprintShortRepresenter.new(self).to_xml
    end

    def self.from_xml(data)
      data.include?("<Imprint>") ? ImprintRepresenter.new(self.new).from_xml(data) : ImprintShortRepresenter.new(self.new).from_xml(data)
    end
  end

  class ImprintRepresenter < Representable::Decorator
    include Representable::XML

    self.representation_wrap = :Imprint

    property :name_code_type, as: "NameCodeType", render_filter: ::ONIX::Formatters::TWO_DIGITS
    property :name_code_type_name, as: "NameCodeTypeName"
    property :name_code_value, as: "NameCodeValue"
    property :imprint_name, as: "ImprintName"
  end

  class ImprintShortRepresenter < Representable::Decorator
    include Representable::XML

    self.representation_wrap = :imprint

    property :name_code_type, as: "b241", render_filter: ::ONIX::Formatters::TWO_DIGITS
    property :name_code_type_name, as: "b242"
    property :name_code_value, as: "b243"
    property :imprint_name, as: "b079"
  end
end
