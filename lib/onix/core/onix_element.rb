module ONIX

  class ONIXElement

    include ROXML


    def self.onix_two_digit_code(name, tag_name, options = {})
      options = options.merge(
        :from => tag_name,
        :as => Fixnum,
        :to_xml => ONIX::Formatters.two_digit
      )
      xml_accessor(name, options)
    end


    def self.onix_space_separated_list(name, tag_name, options = {})
      options = options.merge(
        :from => tag_name,
        :to_xml => ONIX::Formatters.space_separated
      )
      prep = lambda { |v| v ? v.split : [] }
      xml_accessor(name, options, &prep)
    end

  end

end
