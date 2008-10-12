module ONIX
  class MediaFile
    include ROXML

    xml_accessor :media_file_type_code, :from => "MediaFileTypeCode"
    xml_accessor :media_file_format_code, :from => "MediaFileFormatCode"
    xml_accessor :image_resolution, :from => "ImageResolution"
    xml_accessor :media_file_link_type_code, :from => "MediaFileLinkTypeCode"
    xml_accessor :media_file_link, :from => "MediaFileLink"
  end
end
