module ONIX
  class Subject
    include XML::Mapping

    numeric_node :subject_scheme_id,   "SubjectSchemeIdentifier"
    text_node    :subject_scheme_name, "SubjectSchemeName", :optional => true
    text_node    :subject_scheme_version, "SubjectSchemeVersion", :optional => true
    text_node    :subject_code,        "SubjectCode", :optional => true
    text_node    :subject_heading_text, "SubjectHeadingText", :optional => true
  end
end
