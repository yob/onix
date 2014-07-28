# coding: utf-8

module ONIX
  class MediaFile
    include Virtus.model

    attribute :media_file_type_code, Integer
    attribute :media_file_format_code, Integer
    attribute :image_resolution
    attribute :media_file_link_type_code, Integer
    attribute :media_file_link

    def to_xml
      MediaFileRepresenter.new(self).to_xml
    end

    def self.from_xml(data)
      MediaFileRepresenter.new(self.new).from_xml(data)
    end
  end

  class MediaFileRepresenter < Representable::Decorator
    include Representable::XML

    self.representation_wrap = :MediaFile

    property :media_file_type_code, as: "MediaFileTypeCode", render_filter: ::ONIX::Formatters::TWO_DIGITS
    property :media_file_format_code, as: "MediaFileFormatCode", render_filter: ::ONIX::Formatters::TWO_DIGITS
    property :image_resolution, as: "ImageResolution"
    property :media_file_link_type_code, as: "MediaFileLinkTypeCode", render_filter: ::ONIX::Formatters::TWO_DIGITS
    property :media_file_link, as: "MediaFileLink"
  end
end
