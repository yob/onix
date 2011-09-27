# coding: utf-8

class ONIX::TextItemIdentifier < ONIX::Identifier
  xml_name "TextItemIdentifier"
  onix_code_from_list :text_item_identifier, "TextItemIdentifier", :list => 43
end
