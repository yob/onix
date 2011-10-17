# coding: utf-8

class ONIX::Bible < ONIX::Element
  xml_name "Bible"
  onix_codes_from_list :bible_contents, "BibleContents", :list => 82
  onix_codes_from_list :bible_versions, "BibleVersion", :list => 83
  onix_code_from_list :study_bible_type, "StudyBibleType", :list => 84
  onix_codes_from_list :bible_purposes, "BiblePurpose", :list => 85
  onix_code_from_list :bible_text_organization, "BibleTextOrganization", :list => 86
  onix_code_from_list :bible_reference_location, "BibleReferenceLocation", :list => 87
  onix_codes_from_list :bible_text_features, "BibleTextFeature", :list => 97
end
