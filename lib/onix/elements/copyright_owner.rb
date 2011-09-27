# coding: utf-8

class ONIX::CopyrightOwner < ONIX::Element
  xml_name "CopyrightOwner"
  onix_composite :copyright_owner_identifier, ONIX::CopyrightOwnerIdentifier, :singular => true
  xml_accessor :person_name, :from => "PersonName"
  xml_accessor :corporate_name, :from => "CorporateName"
end
