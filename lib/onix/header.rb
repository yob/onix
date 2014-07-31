# coding: utf-8

module ONIX
  class Header
    include Virtus.model

    attribute :from_ean_number
    attribute :from_san
    attribute :sender_identifiers, Array[ONIX::SenderIdentifier]
    attribute :from_company
    attribute :from_person
    attribute :from_email
    attribute :to_ean_number
    attribute :to_san
    attribute :addressee_identifiers, Array[ONIX::AddresseeIdentifier]
    attribute :to_company
    attribute :to_person
    attribute :message_number
    attribute :message_repeat, Integer
    attribute :sent_date
    attribute :message_note

    # defaults
    attribute :default_language_of_text
    attribute :default_price_type_code, Integer
    attribute :default_currency_code
    attribute :default_linear_unit # deprecated in ONIX spec
    attribute :default_weight_unit # deprecated in ONIX spec
    attribute :default_class_of_trade

    def to_xml
      HeaderRepresenter.new(self).to_xml
    end

    def self.from_xml(data)
      HeaderRepresenter.new(self.new).from_xml(data)
    end
  end

  class HeaderRepresenter < Representable::Decorator
    include Representable::XML

    self.representation_wrap = :Header

    property :from_ean_number, as: "FromEANNumber"
    property :from_san, as: "FromSAN"
    collection :sender_identifiers, as: "SenderIdentifier", extend: ONIX::SenderIdentifierRepresenter, class: ONIX::SenderIdentifier
    property :from_company, as: "FromCompany"
    property :from_person, as: "FromPerson"
    property :from_email, as: "FromEmail"
    property :to_ean_number, as: "ToEANNumber"
    property :to_san, as: "ToSAN"
    collection :addressee_identifiers, as: "AddresseeIdentifier", extend: ONIX::AddresseeIdentifierRepresenter, class: ONIX::AddresseeIdentifier
    property :to_company, as: "ToCompany"
    property :to_person, as: "ToPerson"
    property :message_number, as: "MessageNumber"
    property :message_repeat, as: "MessageRepeat"
    property :sent_date, as: "SentDate", render_filter: ::ONIX::Formatters::YYYYMMDD, parse_filter: ->(value, *context) { Date.parse(value) rescue nil }
    property :message_note, as: "MessageNote"
    property :default_language_of_text, as: "DefaultLanguageOfText"
    property :default_price_type_code, as: "DefaultPriceTypeCode", render_filter: ::ONIX::Formatters::TWO_DIGITS
    property :default_currency_code, as: "DefaultCurrencyCode"
    property :default_linear_unit, as: "DefaultLinearUnit"
    property :default_weight_unit, as: "DefaultWeightUnit"
    property :default_class_of_trade, as: "DefaultClassOfTrade"
  end

end
