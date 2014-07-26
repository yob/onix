# coding: utf-8

module ONIX
  class Title
    include Virtus.model

    attribute :title_type, Integer
    attribute :title_text
    attribute :title_prefix
    attribute :title_without_prefix
    attribute :subtitle

    def to_xml
      TitleRepresenter.new(self).to_xml
    end

    def self.from_xml(data)
      TitleRepresenter.new(self.new).from_xml(data)
    end
  end

  class TitleRepresenter < Representable::Decorator
    include Representable::XML

    self.representation_wrap = :Title

    property :title_type, as: "TitleType", render_filter: ::ONIX::Formatters::TWO_DIGITS
    property :title_text, as: "TitleText"
    property :title_prefix, as: "TitlePrefix"
    property :title_without_prefix, as: "TitleWithoutPrefix"
    property :subtitle, as: "Subtitle"
  end
end
