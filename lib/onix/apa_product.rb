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

    # retrieve the current ISBN 10
    def isbn10
      identifier(2)
    end

    # set a new ISBN 10
    def isbn10=(isbn)
      identifier_set(2, isbn)
    end

    # retrieve the current ISBN 13
    def isbn13
      identifier(3)
    end

    # set a new ISBN 13
    def isbn13=(isbn)
      identifier_set(3, isbn)
    end

    # retrieve the current title
    def title
      composite = product.titles.first
      if compsite.nil?
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
      if compsite.nil?
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
      website(2)
    end

    # set a new publisher website for this particular product
    def publisher_website=(str)
      website_set(2, str)
    end

    # retrieve the current supplier website for this particular product
    def supplier_website
      website(12)
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

    # retrieve the imprint
    def imprint
      composite = product.imprints.first
      if compsite.nil?
        nil
      else
        composite.imprint_name
      end
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
      publisher_get(1)
    end

    # set a new publisher
    def publisher=(str)
      publisher_set(1, str)
    end

    # retrieve the sales restriction type
    def sales_restriction_type
      composite = product.sales_restrictions.first
      compsite.nil? ? nil : composite.imprint_name
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
      compsite.nil? ? nil : composite.supplier_name
    end

    # set a new supplier name
    def supplier_name=(str)
      composite = find_or_create_supply_detail
      composite.supplier_name = str
    end

    # retrieve the supplier phone number
    def supplier_phone
      composite = product.supplier_details.first
      compsite.nil? ? nil : composite.telephone_number
    end

    # set a new supplier phone number
    def supplier_phone=(str)
      composite = find_or_create_supply_detail
      composite.telephone_number = str
    end

    # retrieve the supplier fax number
    def supplier_fax
      composite = product.supplier_details.first
      compsite.nil? ? nil : composite.fax_number
    end

    # set a new supplier fax number
    def supplier_fax=(str)
      composite = find_or_create_supply_detail
      composite.fax_number = str
    end

    # retrieve the supplier email address
    def supplier_email
      composite = product.supplier_details.first
      compsite.nil? ? nil : composite.email_address
    end

    # set a new supplier email address
    def supplier_email=(str)
      composite = find_or_create_supply_detail
      composite.email_address = str
    end

    # retrieve the supply country code
    def supply_country
      composite = product.supplier_details.first
      compsite.nil? ? nil : composite.supply_to_country
    end

    # set a new supply country code
    def supply_country=(str)
      composite = find_or_create_supply_detail
      composite.supply_to_country = str
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
      price_get(1)
    end

    # set the rrp excluding any sales tax
    def rrp_exc_sales_tax=(num)
      price_set(1, num)
    end

    # retrieve the rrp including any sales tax
    def rrp_inc_sales_tax
      price_get(2)
    end

    # set the rrp including any sales tax
    def rrp_inc_sales_tax=(num)
      price_set(2, num)
    end

    private

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
      isbn_id = product.product_identifiers.find { |id| id.product_id_type == type }
      isbn_id ? isbn_id.id_value : nil
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

      # store the new value
      isbn_id.id_value = value.to_s
    end

    # retrieve the value of a particular price
    def price_get(type)
      supply = find_or_create_supply_detail
      p = supply.prices.find { |p| p.price_type_code == type }
      p ? p.price_amount : nil
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
      pub = product.publishers.find { |pub| pub.publishing_role == type }
      pub ? pub.publisher_name : nil
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

    # retrieve the value of a particular website
    def website(type)
      site = product.websites.find { |site| site.website_role == type }
      site ? site.website_link : nil
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
