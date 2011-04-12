# coding: utf-8

module ONIX

  # Builds hashes for all code lists in the ONIX spec.
  #
  # Use like so:
  #
  #   ONIX::Lists.list(7)
  #   => { "BB" => "Hardback", ... }
  #
  # There are also some constants for commonly used lists:
  #
  #   ONIX::Lists::PRODUCT_FORM
  #   => { "BB" => "Hardback", ... }
  #
  class Lists
    include Singleton

    # retrieve a hash with the specified code list
    #
    #  ONIX::Lists.list(7)
    #  => { "BB" => "Hardback", ... }
    #
    def self.list(number)
      self.instance.list(number)
    end

    # Return a hash with the data for a single code list.
    #
    # Number should be a fixnum specifying the list to retrieve:
    #
    #  ONIX::Lists.instance.list(7)
    #  => { "BB" => "Hardback", ... }
    #
    def list(number)
      raise "Invalid list number: #{number}"  unless number.to_s.match(/^\d+$/)
      require File.join("onix", "codelists", number.to_s.rjust(3, "0"))
      eval("ONIX::CodeLists::LIST_#{number}")
    end

    # Shortcut to retrieve a common code list
    #
    def self.audience_code
      self.instance.list(28)
    end

    # Shortcut to retrieve a common code list
    #
    def self.contributor_role
      self.instance.list(17)
    end

    # Shortcut to retrieve a common code list
    #
    def self.country_code
      self.instance.list(91)
    end

    # Shortcut to retrieve a common code list
    #
    def self.language_code
      self.instance.list(74)
    end

    # Shortcut to retrieve a common code list
    #
    def self.language_role
      self.instance.list(22)
    end

    # Shortcut to retrieve a common code list
    #
    def self.notification_type
      self.instance.list(1)
    end

    # Shortcut to retrieve a common code list
    #
    def self.product_availability
      self.instance.list(65)
    end

    # Shortcut to retrieve a common code list
    #
    def self.product_form
      self.instance.list(7)
    end

    # Shortcut to retrieve a common code list
    #
    def self.product_form_detail
      self.instance.list(78)
    end

    # These are here for backwards compatability with the onix gem <= 0.8.3
    AUDIENCE_CODE        = ONIX::Lists.audience_code
    CONTRIBUTOR_ROLE     = ONIX::Lists.contributor_role
    COUNTRY_CODE         = ONIX::Lists.country_code
    LANGUAGE_CODE        = ONIX::Lists.language_code
    LANGUAGE_ROLE        = ONIX::Lists.language_role
    NOTIFICATION_TYPE    = ONIX::Lists.notification_type
    PRODUCT_AVAILABILITY = ONIX::Lists.product_availability
    PRODUCT_FORM         = ONIX::Lists.product_form
    PRODUCT_FORM_DETAIL  = ONIX::Lists.product_form_detail

  end
end
