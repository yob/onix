# coding: utf-8

module ONIX
  class APAProduct < SimpleProduct

    delegate :record_reference, :record_reference=
    delegate :notification_type, :notification_type=
    delegate :product_form, :product_form=
    delegate :series, :series=
    delegate :edition, :edition=
    delegate :number_of_pages, :number_of_pages=
    delegate :bic_main_subject, :bic_main_subject=
    delegate :publishing_status, :publishing_status=
    delegate :publication_date, :publication_date=

    def measurement_system
      @measurement_system ||= :metric
    end

    def measurement_system=(value)
      if value == :metric || value == :imperial
        @measurement_system = value
      else
        raise ArgumentError, "#{value} is not a recognised measurement system"
      end
    end

    # retrieve the current EAN
    def ean
      identifier(3).andand.id_value
    end

    # set a new EAN
    def ean=(isbn)
      identifier_set(3, isbn)
    end

    # retrieve the proprietary ID
    def proprietary_id
      identifier(1).andand.id_value
    end

    # set a new proprietary ID
    def proprietary_id=(isbn)
      identifier_set(1, isbn)
    end

    # retrieve the current ISBN 10
    def isbn10
      identifier(2).andand.id_value
    end

    # set a new ISBN 10
    def isbn10=(isbn)
      identifier_set(2, isbn)
    end

    # retrieve the current ISBN 13
    def isbn13
      identifier(15).andand.id_value
    end

    # set a new ISBN 13
    def isbn13=(isbn)
      identifier_set(15, isbn)
    end

    # retrieve the current title
    def title
      composite = product.titles.first
      if composite.nil?
        nil
      else
        composite.title_text || composite.title_without_prefix
      end
    end

    # set a new title
    def title=(str)
      composite = product.titles.first
      if composite.nil?
        composite =  ONIX::Title.new
        composite.title_type = 1
        product.titles << composite
      end
      composite.title_text = str
    end

    # retrieve the current subtitle
    def subtitle
      composite = product.titles.first
      if composite.nil?
        nil
      else
        composite.subtitle
      end
    end

    # set a new subtitle
    def subtitle=(str)
      composite = product.titles.first
      if composite.nil?
        composite =  ONIX::Title.new
        composite.title_type = 1
        product.titles << composite
      end
      composite.subtitle = str
    end

    # retrieve the current publisher website for this particular product
    def publisher_website
      website(2).andand.website_link
    end

    # set a new publisher website for this particular product
    def publisher_website=(str)
      website_set(2, str)
    end

    # retrieve the current supplier website for this particular product
    def supplier_website
      website(12).andand.website_link
    end

    # set a new supplier website for this particular product
    def supplier_website=(str)
      website_set(12, str)
    end

    # retrieve an array of all contributors
    def contributors
      product.contributors.collect { |contrib| contrib.person_name_inverted || contrib.person_name}
    end

    # set a new contributor to this product
    # str should be the contributors name inverted (Healy, James)
    def add_contributor(str, role = "A01")
      contrib = ::ONIX::Contributor.new
      contrib.sequence_number = product.contributors.size + 1
      contrib.contributor_role = role
      contrib.person_name_inverted = str
      product.contributors << contrib
    end

    # return an array of BIC subjects for this title
    # could be version 1 or version 2, most ONIX files don't
    # specifiy
    def bic_subjects
      subjects = product.subjects.select { |sub| sub.subject_scheme_id.to_i == 12 }
      subjects.collect { |sub| sub.subject_code}
    end

    # add a BIC subject code to the product
    def add_bic_subject(code)
      add_subject code, "12"
    end

    # return an array of BISAC subjects for this title
    def bisac_subjects
      subjects = product.subjects.select { |sub| sub.subject_scheme_id.to_i == 10 }
      subjects.collect { |sub| sub.subject_code}
    end

    # add a BISAC subject code to the product
    def add_bisac_subject(code)
      add_subject code, "10"
    end

    # retrieve the url to the product cover image
    def cover_url
      media_file(4).andand.media_file_link
    end

    # set the url to the product cover image
    def cover_url=(url)
      # 4 - cover image
      # 1 - URI
      media_file_set(4,1,url)
    end

    # retrieve the url to the high quality product cover image
    def cover_url_hq
      media_file(6).andand.media_file_link
    end

    # set the url to the high quality product cover image
    def cover_url_hq=(url)
      # 6 - hq cover image
      # 1 - URI
      media_file_set(6,1,url)
    end

    # retrieve the url to the product thumbnail
    def thumbnail_url
      media_file(7).andand.media_file_link
    end

    # set the url to the product cover image
    def thumbnail_url=(url)
      # 7 - thumbnail image
      # 1 - URI
      media_file_set(7,1,url)
    end

    # retrieve the main description
    def main_description
      other_text(1).andand.text
    end

    # set the main description
    def main_description=(t)
      other_text_set(1,t)
    end

    # retrieve the short description
    def short_description
      other_text(2).andand.text
    end

    # set the short description
    def short_description=(t)
      other_text_set(2,t)
    end

    # retrieve the long description
    def long_description
      other_text(3).andand.text
    end

    # set the long description
    def long_description=(t)
      other_text_set(3,t)
    end

    # retrieve the imprint
    def imprint
      composite = product.imprints.first
      composite ? composite.imprint_name : nil
    end

    # set a new imprint
    def imprint=(str)
      composite = product.imprints.first
      if composite.nil?
        composite =  ONIX::Imprint.new
        product.imprints << composite
      end
      composite.imprint_name = str
    end

    # retrieve the publisher
    def publisher
      publisher_get(1).andand.publisher_name
    end

    # set a new publisher
    def publisher=(str)
      publisher_set(1, str)
    end

    # retrieve the sales restriction type
    def sales_restriction_type
      composite = product.sales_restrictions.first
      composite.nil? ? nil : composite.imprint_name
    end

    # set a new sales restriction type
    def sales_restriction_type=(type)
      composite = product.sales_restrictions.first
      if composite.nil?
        composite =  ONIX::SalesRestriction.new
        product.sales_restrictions << composite
      end
      composite.sales_restriction_type = type
    end

    # retrieve the supplier name
    def supplier_name
      composite = product.supplier_details.first
      composite.nil? ? nil : composite.supplier_name
    end

    # set a new supplier name
    def supplier_name=(str)
      composite = find_or_create_supply_detail
      composite.supplier_name = str
    end

    # retrieve the supplier phone number
    def supplier_phone
      composite = product.supplier_details.first
      composite.nil? ? nil : composite.telephone_number
    end

    # set a new supplier phone number
    def supplier_phone=(str)
      composite = find_or_create_supply_detail
      composite.telephone_number = str
    end

    # retrieve the supplier fax number
    def supplier_fax
      composite = product.supplier_details.first
      composite.nil? ? nil : composite.fax_number
    end

    # set a new supplier fax number
    def supplier_fax=(str)
      composite = find_or_create_supply_detail
      composite.fax_number = str
    end

    # retrieve the supplier email address
    def supplier_email
      composite = product.supplier_details.first
      composite.nil? ? nil : composite.email_address
    end

    # set a new supplier email address
    def supplier_email=(str)
      composite = find_or_create_supply_detail
      composite.email_address = str
    end

    # retrieve the supply country code
    def supply_country
      composite = product.supplier_details.first
      composite.nil? ? nil : composite.supply_to_country
    end

    # set a new supply country code
    def supply_country=(str)
      composite = find_or_create_supply_detail
      composite.supply_to_country = str
    end

    # retrieve the product availability code
    def product_availability
      composite = product.supplier_details.first
      composite.nil? ? nil : composite.product_availability
    end

    # set a new product availability
    def product_availability=(num)
      composite = find_or_create_supply_detail
      composite.product_availability = num
    end

    # retrieve the number in stock
    def on_hand
      supply = find_or_create_supply_detail
      composite = supply.stock.first
      if composite.nil?
        composite = ONIX::Stock.new
        supply.stock << composite
      end
      composite.on_hand
    end

    # set a new in stock quantity
    def on_hand=(num)
      supply = find_or_create_supply_detail
      composite = supply.stock.first
      if composite.nil?
        composite = ONIX::Stock.new
        supply.stock << composite
      end
      composite.on_hand = num
    end

    # retrieve the number on order
    def on_order
      supply = find_or_create_supply_detail
      composite = supply.stock.first
      if composite.nil?
        composite = ONIX::Stock.new
        supply.stock << composite
      end
      composite.on_order
    end

    # set a new on order quantity
    def on_order=(num)
      supply = find_or_create_supply_detail
      composite = supply.stock.first
      if composite.nil?
        composite = ONIX::Stock.new
        supply.stock << composite
      end
      composite.on_order = num
    end

    # retrieve the rrp excluding any sales tax
    def rrp_exc_sales_tax
      price_get(1).andand.price_amount
    end

    # set the rrp excluding any sales tax
    def rrp_exc_sales_tax=(num)
      price_set(1, num)
    end

    # retrieve the rrp including any sales tax
    def rrp_inc_sales_tax
      price_get(2).andand.price_amount
    end

    # set the rrp including any sales tax
    def rrp_inc_sales_tax=(num)
      price_set(2, num)
    end

    # just get the first price we can find, regardless of the type.
    # useful as a backup for reading files from that don't contain a type
    def price
      price_get(nil).andand.price_amount
    end

    # retrieve the height of the product
    #
    # If APAProduct#measurement_system is metric, these will be in mm, otherwise they
    # will be in inches.
    #
    def height
      # TODO: auto unit conversion
      measurement(1).andand.measurement
    end

    # set the height of the book
    #
    # If APAProduct#measurement_system is metric, this should be in mm, otherwise it
    # will be in inches.
    #
    def height=(value)
      if measurement_system == :metric
        measurement_set(1,value, "mm")
      elsif measurement_system == :imperial
        measurement_set(1,value, "in")
      end
    end

    # retrieve the width of the product
    #
    # If APAProduct#measurement_system is metric, these will be in mm, otherwise they
    # will be in inches.
    #
    def width
      # TODO: auto unit conversion
      measurement(2).andand.measurement
    end

    # set the width of the product
    #
    # If APAProduct#measurement_system is metric, this should be in mm, otherwise it
    # will be in inches.
    #
    def width=(value)
      if measurement_system == :metric
        measurement_set(2,value, "mm")
      elsif measurement_system == :imperial
        measurement_set(2,value, "in")
      end
    end

    # retrieve the weight of the product
    #
    # If APAProduct#measurement_system is metric, these will be in grams, otherwise they
    # will be in ounces.
    #
    def weight
      # TODO: auto unit conversion
      measurement(8).andand.measurement
    end

    # set the weight of the product
    #
    # If APAProduct#measurement_system is metric, this should be in grams, otherwise it
    # will be in ounces.
    #
    def weight=(value)
      if measurement_system == :metric
        measurement_set(8,value, "gr")
      elsif measurement_system == :imperial
        measurement_set(8,value, "oz")
      end
    end

    # retrieve the thickness of the product
    #
    # If APAProduct#measurement_system is metric, these will be in mm, otherwise they
    # will be in inches.
    #
    def thickness
      # TODO: auto unit conversion
      measurement(3).andand.measurement
    end

    # set the thickness of the product
    #
    # If APAProduct#measurement_system is metric, this should be in mm, otherwise it
    # will be in inches.
    #
    def thickness=(value)
      if measurement_system == :metric
        measurement_set(3,value, "mm")
      elsif measurement_system == :imperial
        measurement_set(3,value, "in")
      end
    end

    def agent_name
      reps = product.market_representations.first
      return nil if reps.nil?
      reps.agent_name
    end

    def agent_name=(value)
      reps = product.market_representations.first
      if reps.nil?
        reps = ONIX::MarketRepresentation.new
        product.market_representations << reps
      end
      reps.agent_name = value.to_s
    end

    def market_country
      reps = product.market_representations.first
      return nil if reps.nil?
      reps.market_country
    end

    def market_country=(value)
      reps = product.market_representations.first
      if reps.nil?
        reps = ONIX::MarketRepresentation.new
        product.market_representations << reps
      end
      reps.market_country = value.to_s
    end

    def market_publishing_status
      reps = product.market_representations.first
      return nil if reps.nil?
      reps.market_publishing_status
    end

    def market_publishing_status=(value)
      reps = product.market_representations.first
      if reps.nil?
        reps = ONIX::MarketRepresentation.new
        product.market_representations << reps
      end
      reps.market_publishing_status = value.to_i
    end

    private

    # add a new subject to this product
    # str should be the subject code
    # type should be the code for the subject scheme you're using. See ONIX codelist 27.
    # 12 is BIC
    def add_subject(str, type = "12")
      subject = ::ONIX::Subject.new
      subject.subject_scheme_id = type.to_i
      subject.subject_code = str
      product.subjects << subject
    end

    def find_or_create_supply_detail
      composite = product.supply_details.first
      if composite.nil?
        composite =  ONIX::SupplyDetail.new
        product.supply_details << composite
      end
      composite
    end

    # retrieve the value of a particular ID
    def identifier(type)
      product.product_identifiers.find { |id| id.product_id_type == type }
    end

    # set the value of a particular ID
    def identifier_set(type, value)
      isbn_id = identifier(type)

      # create a new isbn record if we need to
      if isbn_id.nil?
        isbn_id = ONIX::ProductIdentifier.new
        isbn_id.product_id_type = type
        product.product_identifiers << isbn_id
      end

      isbn_id.id_value = value
    end

    # retrieve the value of a particular measurement
    def measurement(type)
      product.measurements.find { |m| m.measure_type_code == type }
    end

    # set the value of a particular measurement
    def measurement_set(type, value, unit)
      measure = measurement(type)

      # create a new isbn record if we need to
      if measure.nil?
        measure = ONIX::Measure.new
        measure.measure_type_code = type
        product.measurements << measure
      end

      # store the new value
      measure.measurement = value
      measure.measure_unit_code = unit.to_s
    end

    # retrieve the value of a particular media file
    def media_file(type)
      product.media_files.find { |m| m.media_file_type_code == type }
    end

    # set the value of a particular ID
    def media_file_set(type, link_type, value)
      media = media_file(type)

      # create a new isbn record if we need to
      if media.nil?
        media = ONIX::MediaFile.new
        media.media_file_type_code = type
        media.media_file_link_type_code = link_type
        product.media_files << media
      end

      # store the new value
      media.media_file_link = value.to_s
    end

    # retrieve the value of a particular price
    def price_get(type)
      supply = find_or_create_supply_detail
      supply.prices.find { |p| p.price_type_code == type }
    end

    # set the value of a particular price
    def price_set(type, num)
      p = price_get(type)

      # create a new isbn record if we need to
      if p.nil?
        supply = find_or_create_supply_detail
        p = ONIX::Price.new
        p.price_type_code = type
        supply.prices << p
      end

      # store the new value
      p.price_amount = num
    end

    # retrieve the value of a particular publisher
    def publisher_get(type)
      product.publishers.find { |pub| pub.publishing_role == type }
    end

    # set the value of a particular ID
    def publisher_set(type, value)
      pub = publisher_get(type)

      # create a new isbn record if we need to
      if pub.nil?
        pub = ONIX::Publisher.new
        pub.publishing_role = type
        product.publishers << pub
      end

      # store the new value
      pub.publisher_name = value.to_s
    end

    # retrieve the value of a particular other text value
    def other_text(type)
      product.text.find { |t| t.text_type_code == type }
    end

    # set the value of a particular other text value
    def other_text_set(type, value)
      text = other_text(type)

      if text.nil?
        text = ONIX::OtherText.new
        text.text_type_code = type
        product.text << text
      end

      # store the new value
      text.text = value.to_s
    end

    # retrieve the value of a particular website
    def website(type)
      product.websites.find { |site| site.website_role == type }
    end

    # set the value of a particular website
    def website_set(type, value)
      site = website(type)

      # create a new website record if we need to
      if site.nil?
        site = ONIX::Website.new
        site.website_role = type
        product.websites << site
      end

      site.website_link = value.to_s
    end
  end
end
