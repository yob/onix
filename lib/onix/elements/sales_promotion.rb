# coding: utf-8

class ONIX::SalesPromotion < ONIX::Element
  xml_name "SalesPromotion"
  xml_accessor :promotion_campaign, :from => "PromotionCampaign"
  xml_accessor :promotion_contact, :from => "PromotionContact"
  xml_accessor :initial_print_run, :from => "InitialPrintRun"
  xml_accessor :reprint_detail, :from => "ReprintDetail"
  xml_accessor :copies_sold, :from => "CopiesSold"
  xml_accessor :book_club_adoption, :from => "BookClubAdoption"
end
