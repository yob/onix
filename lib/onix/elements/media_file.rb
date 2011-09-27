# coding: utf-8

class ONIX::MediaFile < ONIX::Element
  xml_name "MediaFile"
  onix_code_from_list :media_file_type_code, "MediaFileTypeCode", :list => 38
  onix_code_from_list :media_file_format_code, "MediaFileFormatCode", :list => 39
  xml_accessor :image_resolution, :from => "ImageResolution"
  onix_code_from_list :media_file_link_type_code, "MediaFileLinkTypeCode", :list => 40
  xml_accessor :media_file_link, :from => "MediaFileLink"
  xml_accessor :text_with_download, :from => "TextWithDownload"
  xml_accessor :download_caption, :from => "DownloadCaption"
  xml_accessor :download_credit, :from => "DownloadCredit"
  xml_accessor :download_copyright_notice, :from => "DownloadCopyrightNotice"
  xml_accessor :download_terms, :from => "DownloadTerms"
  onix_date_accessor :media_file_date, "MediaFileDate"
end
