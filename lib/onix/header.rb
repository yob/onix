module ONIX
  class Header
    include ROXML

    xml_name "Header"

    xml_accessor :from_ean_number, :from => "FromEANNumber"
    xml_accessor :from_san,        :from => "FromSAN"
    xml_accessor :sender_identifiers, [ONIX::SenderIdentifier], :from => "SenderIdentifier"
    xml_accessor :from_company,    :from => "FromCompany"
    xml_accessor :from_person,     :from => "FromPerson"
    xml_accessor :from_email,      :from => "FromEmail"
    xml_accessor :to_ean_number,   :from => "ToEANNumber"
    xml_accessor :to_san,          :from => "ToSAN"
    xml_accessor :addressee_identifier, [ONIX::AddresseeIdentifier], :from => "AddresseeIdentifier"
    xml_accessor :to_company,      :from => "ToCompany"
    xml_accessor :to_person,       :from => "ToPerson"
    xml_accessor :message_number,  :from => "MessageNumber"
    xml_accessor :message_repeat,  :from => "MessageRepeat", :as => Integer
    xml_accessor :sent_date,       :from => "SentDate", :as => Date
    xml_accessor :message_note,    :from => "MessageNote"

    # defaults
    xml_accessor  :default_language_of_text, :from => "DefaultLanguageOfText"
    xml_accessor  :default_price_type_code, :from => "DefaultPriceTypeCode", :as => Integer
    xml_accessor  :default_currency_code,   :from => "DefaultCurrencyCode"
    xml_reader    :default_linear_unit,     :from => "DefaultLinearUnit"        # deprecated in ONIX spec
    xml_reader    :default_weight_unit,     :from => "DefaultWeightUnit"        # deprecated in ONIX spec
    xml_accessor  :default_class_of_trade,  :from => "DefaultClassOfTrade"
  end
end
