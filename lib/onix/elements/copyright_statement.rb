# coding: utf-8

class ONIX::CopyrightStatement < ONIX::Element
  xml_name "CopyrightStatement"
  xml_accessor :copyright_years, :from => "CopyrightYear", :as => [Fixnum]
  onix_composite :copyright_owners, ONIX::CopyrightOwner
end
