# coding: utf-8

module ONIX2
  class Subject
    include Virtus.model

    attribute :subject_scheme_id, Integer
    attribute :subject_scheme_name
    attribute :subject_scheme_version
    attribute :subject_code
    attribute :subject_heading_text

    def to_xml
      SubjectRepresenter.new(self).to_xml
    end

    def self.from_xml(data)
      SubjectRepresenter.new(self.new).from_xml(data)
    end
  end

  class SubjectRepresenter < Representable::Decorator
    include Representable::XML

    self.representation_wrap = :Subject

    property :subject_scheme_id, as: "SubjectSchemeIdentifier", render_filter: ::ONIX2::Formatters::TWO_DIGITS
    property :subject_scheme_name, as: "SubjectSchemeName"
    property :subject_scheme_version, as: "SubjectSchemeVersion"
    property :subject_code, as: "SubjectCode"
    property :subject_heading_text, as: "SubjectHeadingText"
  end
end
