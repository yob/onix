# coding: utf-8

class ONIX::Reissue < ONIX::Element
  xml_name "Reissue"
  onix_date_accessor :reissue_date, "ReissueDate"
  xml_accessor :reissue_description, :from => "ReissueDescription"
  onix_composite :prices, ONIX::Price
  onix_composite :media_files, ONIX::MediaFile
end
