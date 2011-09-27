# coding: utf-8

class ONIX::Subject < ONIX::Element
  xml_name "Subject"
  onix_code_from_list :subject_scheme_identifier, "SubjectSchemeIdentifier", :list => 27
  xml_accessor :subject_scheme_name, :from => "SubjectSchemeName"
  xml_accessor :subject_scheme_version, :from => "SubjectSchemeVersion"
  xml_accessor :subject_code, :from => "SubjectCode"
  xml_accessor :subject_heading_text, :from => "SubjectHeadingText"
end
