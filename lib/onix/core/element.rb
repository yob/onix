# coding: utf-8

module ONIX

  class Element

    include ROXML

    # An accessor to an array of element instances.
    #
    # Options:
    #
    #   :from - defaults to the class name, but you can override this.
    #   :singular - accessor is not an array, just a single object.
    #
    def self.onix_composite(name, klass, options = {})
      options[:as] = options.delete(:singular) ? klass : [klass]
      options[:from] ||= klass.to_s.split("::").last
      xml_accessor(name, options)
    end

    # An accessor that treats the input/output as a date.
    #
    # Options: none yet.
    #
    def self.onix_date_accessor(name, tag_name, options = {})
      options = options.merge(
        :from => tag_name,
        :to_xml => ONIX::Formatters.yyyymmdd
      )
      xml_accessor(name, options) { |val| Date.parse(val) rescue nil }
    end

    # An accessor that treats the input as a space-separated list, and
    # creates an array for it.
    #
    def self.onix_space_separated_list(name, tag_name, options = {})
      options = options.merge(
        :from => tag_name,
        :to_xml => ONIX::Formatters.space_separated
      )
      prep = lambda { |v| v ? v.split : [] }
      xml_accessor(name, options, &prep)
    end

    # An accessor that maps a "code" string into an ONIX::Code object.
    # A Code object can return the simple code (or "key"), or the value that
    # is associated with it in ONIX code lists, and so on.
    #
    # Special options for Code instantiation are:
    #
    #   :length - how many digits to pad (default is taken from total list size)
    #
    def self.onix_code_from_list(name, tag_name, options = {})
      unless codelist_number = options.delete(:list)
        raise ":list is a required option for onix_code_from_list!"
      end
      prep = lambda { |value| ONIX::Code.new(codelist_number, value, options) }
      options = options.merge(:from => tag_name)
      xml_accessor("#{name}_code", options, &prep)
      define_method(name) { send("#{name}_code").key }
      define_method("#{name}=") { |val|
        val = prep.call(val)  unless val.kind_of?(ONIX::Code)
        send("#{name}_code=", val)
      }
    end

    # Like onix_code_from_list, but for an array of codes.
    #
    # One important caveat: when assigning to this accessor, you must
    # pass in the complete array -- if you assign an array that you later
    # push or shift items into, you might get unexpected results.
    #
    def self.onix_codes_from_list(name, tag_name, options = {})
      unless codelist_number = options.delete(:list)
        raise ":list is a required option for onix_code_from_list!"
      end
      prep = lambda { |value| ONIX::Code.new(codelist_number, value, options) }
      options = options.merge(:from => tag_name)
      xml_accessor("#{name}_codes", options, &prep)
      define_method(name) {
        codes = send("#{name}_codes")
        codes ? codes.collect { |cd| cd.key } : nil
      }
      # FIXME: Hmm, adding to array? what happens with push, etc?
      define_method("#{name}=") { |vals|
        vals = [vals].flatten.collect { |v|
          v.kind_of?(ONIX::Code) ? v : prep.call(v)
        }
        send("#{name}_codes=", vals)
      }
    end

  end

end
