# coding: utf-8

class ONIX::MainSubject < ONIX::Element
  xml_name "MainSubject"
  onix_code_from_list :main_subject_scheme_identifier, "MainSubjectSchemeIdentifier", :list => 26
  xml_accessor :subject_scheme_identifier, :from => "SubjectSchemeIdentifier"
  xml_accessor :subject_code, :from => "SubjectCode"
  xml_accessor :subject_heading_text, :from => "SubjectHeadingText"
end
