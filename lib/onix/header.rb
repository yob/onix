module ONIX
  class Header
    include XML::Mapping

    root_element_name "Header"

    text_node  :sender_ean_number,    "SenderEANNumber", :optional => true
    text_node  :from_san,             "FromSAN", :optional => true
    array_node :sender_identifiers,   "SenderIdentifier", :optional => true, :class => ONIX::SenderIdentifier
    text_node  :from_company,         "FromCompany", :optional => true
    text_node  :from_person,          "FromPerson", :optional => true
    text_node  :from_email,           "FromEmail", :optional => true
    text_node  :to_ean_number,        "ToEANNumber", :optional => true
    text_node  :to_san,               "ToSAN", :optional => true
    array_node :addressee_identifier, "AddresseeIdentifier", :optional => true, :class => ONIX::AddresseeIdentifier
    text_node  :to_company,           "ToCompany", :optional => true
    text_node  :to_person,            "ToPerson", :optional => true
    text_node  :message_number,       "MessageNumber", :optional => true
    text_node  :message_repeat,       "MessageRepeat", :optional => true
    date_node  :sent_date,            "SentDate", :optional => true
    text_node  :message_note,         "MessageNote", :optional => true

    # defaults
    text_node  :default_language_of_text, "DefaultLanguageOfText", :optional => true
    text_node  :default_price_type_code,  "DefaultPriceTypeCode",  :optional => true
    text_node  :default_currency_code,    "DefaultCurrencyCode",   :optional => true
    text_node  :default_linear_unit,      "DefaultLinearUnit",     :optional => true   # TODO deprecated. make read only
    text_node  :default_weight_unit,      "DefaultWeightUnit",     :optional => true   # TODO deprecated. make read only
    text_node  :default_class_of_trade,   "DefaultClassOfTrade",   :optional => true
  end
end
