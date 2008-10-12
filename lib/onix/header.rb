module ONIX
  class Header
    include ROXML

    xml_accessor  :from_person, :from => "FromPerson"
    xml_accessor  :sender_ean_number, :from => "SenderEANNumber"
    xml_accessor  :from_san, :from => "FromSAN"
    #array_node :sender_identifiers, :from => "SenderIdentifier", :class => ONIX::SenderIdentifier
    xml_accessor  :from_company, :from => "FromCompany"
    xml_accessor  :from_email, :from => "FromEmail"
    xml_accessor  :to_ean_number, :from => "ToEANNumber"
    xml_accessor  :to_san,  :from => "ToSAN"
    #array_node :addressee_identifier, "AddresseeIdentifier", :class => ONIX::AddresseeIdentifier
    xml_accessor  :to_company, :from => "ToCompany"
    xml_accessor  :to_person, :from => "ToPerson"
    xml_accessor  :message_number, :from => "MessageNumber"
    xml_accessor  :message_repeat, :from => "MessageRepeat"
    #date_node  :sent_date,            "SentDate"
    xml_accessor  :message_note, :from => "MessageNote"

    # defaults
    xml_accessor  :default_language_of_text, :from => "DefaultLanguageOfText"
    xml_accessor  :default_price_type_code, :from => "DefaultPriceTypeCode"
    xml_accessor  :default_currency_code, :from => "DefaultCurrencyCode"
    xml_reader  :default_linear_unit, :from => "DefaultLinearUnit"        # deprecated
    xml_reader  :default_weight_unit, :from => "DefaultWeightUnit"        # deprecated
    xml_accessor  :default_class_of_trade, :from => "DefaultClassOfTrade"
  end
end
