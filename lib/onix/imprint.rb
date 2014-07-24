# coding: utf-8

module ONIX
  class Imprint
    include Virtus.model

    attribute :name_code_type, Integer
    attribute :name_code_type_name
    attribute :name_code_value
    attribute :imprint_name

    def to_xml
      ImprintRepresenter.new(self).to_xml
    end

    def self.from_xml(data)
      ImprintRepresenter.new(self.new).from_xml(data)
    end
  end

  class ImprintRepresenter < Representable::Decorator
    include Representable::XML

    self.representation_wrap = :Imprint

    property :name_code_type, as: "NameCodeType", getter: ->(**_) { "%02i" % name_code_type unless name_code_type.nil? }
    property :name_code_type_name, as: "NameCodeTypeName"
    property :name_code_value, as: "NameCodeValue"
    property :imprint_name, as: "ImprintName"
  end
end
