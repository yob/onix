module ONIX
  class Header
    include ROXML

    xml_name "Header"

    xml_accessor :from_person,     :etext, :from => "FromPerson"
    xml_accessor :from_ean_number, :etext, :from => "FromEANNumber"
    xml_accessor :from_san,        :etext, :from => "FromSAN"
    xml_accessor :sender_identifiers, [ONIX::SenderIdentifier], :from => "SenderIdentifier"
    xml_accessor :from_company,    :etext, :from => "FromCompany"
    xml_accessor :from_email,      :etext, :from => "FromEmail"
    xml_accessor :to_ean_number,   :etext, :from => "ToEANNumber"
    xml_accessor :to_san,          :etext, :from => "ToSAN"
    xml_accessor :addressee_identifier, [ONIX::AddresseeIdentifier], :from => "AddresseeIdentifier"
    xml_accessor :to_company,      :etext, :from => "ToCompany"
    xml_accessor :to_person,       :etext, :from => "ToPerson"
    xml_accessor :message_number,  :etext, :from => "MessageNumber"
    xml_accessor :message_repeat,  :integer, :from => "MessageRepeat"
    xml_accessor :sent_date,       :yyyymmdd, :from => "SentDate"
    xml_accessor :message_note,    :etext, :from => "MessageNote"

    # defaults
    xml_accessor  :default_language_of_text, :from => "DefaultLanguageOfText"
    xml_accessor  :default_price_type_code, :integer, :from => "DefaultPriceTypeCode"
    xml_accessor  :default_currency_code,   :from => "DefaultCurrencyCode"
    xml_reader    :default_linear_unit,     :from => "DefaultLinearUnit"        # deprecated
    xml_reader    :default_weight_unit,     :from => "DefaultWeightUnit"        # deprecated
    xml_accessor  :default_class_of_trade,  :from => "DefaultClassOfTrade"
  end
end
