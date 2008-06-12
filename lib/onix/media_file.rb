module ONIX
  class MediaFile
    include XML::Mapping

    numeric_node :media_file_type_code,   "MediaFileTypeCode"
    numeric_node :media_file_format_code, "MediaFileFormatCode", :optional => true
    numeric_node :image_resolution,       "ImageResolution",     :optional => true
    numeric_node :media_file_link_type_code, "MediaFileLinkTypeCode", :optional => true
    text_node    :media_file_link,        "MediaFileLink"
  end
end
