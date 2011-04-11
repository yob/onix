# coding: utf-8

module ONIX
  class MediaFile < ONIX::Element
    xml_name "MediaFile"
    onix_code_from_list(:media_file_type_code, "MediaFileTypeCode", :list => 38)
    onix_code_from_list(:media_file_format_code, "MediaFileFormatCode", :list => 39)
    xml_accessor :image_resolution, :from => "ImageResolution"
    onix_code_from_list(:media_file_link_type_code, "MediaFileLinkTypeCode", :list => 40)
    xml_accessor :media_file_link, :from => "MediaFileLink"
  end
end
