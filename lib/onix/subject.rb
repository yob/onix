module ONIX
  class Subject
    include ROXML

    xml_accessor :subject_scheme_id,      :from => "SubjectSchemeIdentifier", :as => Integer # should be a 2 digit num
    xml_accessor :subject_scheme_name,    :from => "SubjectSchemeName"
    xml_accessor :subject_scheme_version, :from => "SubjectSchemeVersion"
    xml_accessor :subject_code,           :from => "SubjectCode"
    xml_accessor :subject_heading_text,   :from => "SubjectHeadingText"
  end
end
