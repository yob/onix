# coding: utf-8

module ONIX2
  class OtherText
    include Virtus.model

    attribute :text_type_code, Integer
    attribute :text_format
    attribute :text
    attribute :text_link_type,Integer
    attribute :text_link
    attribute :text_author

    def to_xml
      OtherTextRepresenter.new(self).to_xml
    end

    def self.from_xml(data)
      OtherTextRepresenter.new(self.new).from_xml(data)
    end
  end

  class OtherTextRepresenter < Representable::Decorator
    include Representable::XML

    self.representation_wrap = :OtherText

    property :text_type_code, as: "TextTypeCode", render_filter: ::ONIX2::Formatters::TWO_DIGITS
    property :text_format, as: "TextFormat"
    property :text, as: "Text"
    property :text_link_type, as: "TextLinkType", render_filter: ::ONIX2::Formatters::TWO_DIGITS
    property :text_link, as: "TextLink"
    property :text_author, as: "TextAuthor"
  end
end
