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

    def isbn10
      isbn_id = product.product_identifiers.find { |id| id.product_id_type == 2 }
      isbn_id ? isbn_id.id_value : nil
    end

    def isbn10=(isbn)
      # find the existing ISBN10 if there is one
      isbn_id = product.product_identifiers.find { |id| id.product_id_type == 2 }

      # create a new isbn record if we need to
      if isbn_id.nil?
        isbn_id = ONIX::ProductIdentifier.new
        isbn_id.product_id_type = 2
        product.product_identifiers << isbn_id
      end

      # store the new value
      isbn_id.id_value = isbn.to_s
    end

    def isbn13
      isbn_id = product.product_identifiers.find { |id| id.product_id_type == 3 }
      isbn_id ? isbn_id.id_value : nil
    end

    def isbn13=(isbn)
      # find the existing ISBN10 if there is one
      isbn_id = product.product_identifiers.find { |id| id.product_id_type == 3 }

      # create a new isbn record if we need to
      if isbn_id.nil?
        isbn_id = ONIX::ProductIdentifier.new
        isbn_id.product_id_type = 3
        product.product_identifiers << isbn_id
      end

      # store the new value
      isbn_id.id_value = isbn.to_s
    end

    def title
      composite = product.titles.first
      if compsite.nil?
        nil
      else
        composite.title_text || composite.title_without_prefix
      end
    end

    def title=(str)
      composite = product.titles.first
      if composite.nil?
        composite =  ONIX::Title.new
        composite.title_type = 1
        product.titles << composite
      end
      composite.title_text = str
    end

    def subtitle
      composite = product.titles.first
      if compsite.nil?
        nil
      else
        composite.subtitle
      end
    end

    def subtitle=(str)
      composite = product.titles.first
      if composite.nil?
        composite =  ONIX::Title.new
        composite.title_type = 1
        product.titles << composite
      end
      composite.subtitle = str
    end
  end
end
