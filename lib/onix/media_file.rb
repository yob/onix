module ONIX
  class MediaFile
    include ROXML

    xml_accessor :media_file_type_code, :from => "MediaFileTypeCode", :as => Integer # should be a 2 digit num
    xml_accessor :media_file_format_code, :from => "MediaFileFormatCode", :as => Integer # should be a 2 digit num
    xml_accessor :image_resolution, :from => "ImageResolution"
    xml_accessor :media_file_link_type_code, :from => "MediaFileLinkTypeCode", :as => Integer # should be a 2 digit num
    xml_accessor :media_file_link, :from => "MediaFileLink"
  end
end
