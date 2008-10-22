module ONIX
  class Subject
    include ROXML

    xml_accessor :subject_scheme_id,   :twodigit, :from => "SubjectSchemeIdentifier"
    xml_accessor :subject_scheme_name,            :from => "SubjectSchemeName"
    xml_accessor :subject_scheme_version,         :from => "SubjectSchemeVersion"
    xml_accessor :subject_code,                   :from => "SubjectCode"
    xml_accessor :subject_heading_text,           :from => "SubjectHeadingText"
  end
end
