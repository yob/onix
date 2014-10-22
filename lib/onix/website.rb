# coding: utf-8

module ONIX2
  class Website
    include Virtus.model

    attribute :website_role, Integer
    attribute :website_description
    attribute :website_link

    def to_xml
      WebsiteRepresenter.new(self).to_xml
    end

    def self.from_xml(data)
      WebsiteRepresenter.new(self.new).from_xml(data)
    end
  end

  class WebsiteRepresenter < Representable::Decorator
    include Representable::XML

    self.representation_wrap = :Website

    property :website_role, as: "WebsiteRole", render_filter: ::ONIX2::Formatters::TWO_DIGITS
    property :website_description, as: "WebsiteDescription"
    property :website_link, as: "WebsiteLink"
  end
end
