# coding: utf-8
# milkfarm
module ONIX
  class SLProduct < APAProduct

    delegate :copyright_year, :copyright_year=
    delegate :product_form_detail, :product_form_detail=
    
    # retrieve the proprietary series ID
    def proprietary_series_id
      series_identifier(1).andand.id_value
    end

    # set a new proprietary series ID
    def proprietary_series_id=(id)
      series_identifier_set(1, id)
    end
    
    # retrieve the issn
    def issn
      series_identifier(2).andand.id_value
    end

    # set a new issn
    def issn=(id)
      series_identifier_set(2, id)
    end
    
    # retrieve the value of a particular ID
    def series_identifier(type)
      product.series_identifiers.find { |id| id.series_id_type == type }
    end

    # set the value of a particular ID
    def series_identifier_set(type, value)
      series_id = series_identifier(type)

      # create a new series identifier record if we need to
      if series_id.nil?
        series_id = ONIX::SeriesIdentifier.new
        series_id.series_id_type = type
        product.series_identifiers << series_id
      end

      series_id.id_value = value
    end
    
    # retrieve the value of a particular ID
    def series(str)
      product.series.find { |id| id.title_of_series == series }
    end

    # set the value of a particular ID
    def series=(value)
      series_id = series(value)

      # create a new series record if we need to
      if series_id.nil?
        series_id = ONIX::Series.new
        series_id.title_of_series = value
        product.series << series_id
      end
    end
    
    # retrieve the "language of text" (role=1) language code for this particular product
    def language_code
      language(1).andand.language_code
    end

    # set a new "language of text" (role=1) language code for this particular product
    def language_code=(str)
      language_set(1, str)
    end
    
    # retrieve the "language of text" (role=1) country code for this particular product
    def country_code
      language(1).andand.country_code
    end

    # set a new "language of text" (role=1) country code for this particular product
    def country_code=(str)
      language_set(1, language_code, str)
    end
    
    # retrieve the value of a particular language
    def language(type)
      product.languages.find { |l| l.language_role == type }
    end

    # set the value of a particular language
    def language_set(type, value, value2=nil)
      l = language(type)

      # create a new language record if we need to
      if l.nil?
        l = ONIX::Language.new
        l.language_role = type
        product.languages << l
      end

      # cannot set country_code without language_code
      unless value.nil?
        l.language_code = value.to_s # mandatory
        l.country_code = value2.to_s if value2 # optional
      end
    end
    
    # retrieve the dewey for this title
    def dewey
      product.subjects.find { |sub| sub.subject_scheme_id.to_i == 1 } # dewey = 1, abridged dewey = 2
    end

    # add a dewey to the product
    def dewey=(code)
      add_subject code, "1" # dewey = 1, abridged dewey = 2
    end
    
    # audience_range_qualifier: 11 = US school grades
    # audience_range_precision: 1 = exact, 3 = from, 4 = to
    def us_grade_range
      audience_range(11)
    end

    # set a new "audience of text" (role=1) country code for this particular product
    def us_grade_range=(range=[])
      audience_range_set(11, range[0], range[1])
    end
    
    # retrieve the value of a particular audience range
    def audience_range(type)
      product.audience_ranges.find { |a| a.audience_range_qualifier == type }
    end

    # set the value of a particular audience_range
    def audience_range_set(type, min=nil, max=nil)
      a = audience_range(type)

      # create a new audience_range record if we need to
      if a.nil?
        a = ONIX::AudienceRange.new
        a.audience_range_qualifier = type
        product.audience_ranges << a
      end

      unless min.nil?
        a.audience_range_precisions << "03"
        a.audience_range_values << min
      end
      unless max.nil?
        a.audience_range_precisions << "04"
        a.audience_range_values << max
      end
      a.audience_range_precisions = ["01"] if min.nil? || max.nil?
    end

  end
end
