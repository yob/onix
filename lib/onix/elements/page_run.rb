# coding: utf-8

class ONIX::PageRun < ONIX::Element
  xml_name "PageRun"
  xml_accessor :first_page_number, :from => "FirstPageNumber"
  xml_accessor :last_page_number, :from => "LastPageNumber"
end
