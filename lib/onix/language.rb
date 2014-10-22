# coding: utf-8

module ONIX2
  class Language
    include Virtus.model

    attribute :language_role, Integer
    attribute :language_code
    attribute :country_code

    def to_xml
      LanguageRepresenter.new(self).to_xml
    end

    def self.from_xml(data)
      LanguageRepresenter.new(self.new).from_xml(data)
    end
  end

  class LanguageRepresenter < Representable::Decorator
    include Representable::XML

    self.representation_wrap = :Language

    property :language_role, as: "LanguageRole", render_filter: ::ONIX2::Formatters::TWO_DIGITS
    property :language_code, as: "LanguageCode"
    property :country_code, as: "CountryCode"
  end
end
