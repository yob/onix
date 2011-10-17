# coding: utf-8


module ONIX

  class Code

    attr_reader :key, :value, :list, :list_number

    # Note re: key type. For backwards compatibility, code keys that are
    # all-digits are passed around in this gem as Fixnums.
    #
    # The actual code list hashes have string-based keys for consistency. If
    # you want the integer-or-string key, use Code#key. If you want the real
    # string key, use Code#to_s.
    #
    # If the key is not found in the list, the behaviour depends on the
    # :enforce option. By default, it returns a code with key and value set to
    # nil. If :enforce is true, an exception is raised. If :enforce is false,
    # the key and value is the data given in the tag.
    #
    def initialize(list_number, data, options = {})
      @list_number = list_number
      unless @list = ONIX::Lists.list(@list_number)
        raise ONIX::CodeListNotFound.new(@list_number)
      end

      @key = @value = nil
      return  if data.nil? || data == ""

      if data.kind_of?(Fixnum)
        @key = data
        pad_length = options[:length] || ["#{@list.size}".size, 2].max
        @real_key = pad(data, pad_length)
      elsif data.match(/^\d+$/) && @list.keys.include?(data)
        @key = data.to_i
        @real_key = data
      elsif @list.keys.include?(data)
        @key = @real_key = data
      else
        @list.each_pair { |k, v|
          next  unless v == data
          @real_key = k
          @key = @real_key.match(/^\d+$/) ? @real_key.to_i : @real_key
          break
        }
      end
      if @real_key
        @value = @list[@real_key]
      elsif options[:enforce] == true
        raise ONIX::CodeNotFoundInList.new(@list_number, data)
      elsif options[:enforce] == false
        @value = @key = @real_key = data
      else
        @value = @key = @real_key = nil
      end
    end


    # Returns true if the given key has a value in the codelist.
    #
    def valid?
      @value ? true : false
    end


    # Returns the string representation of the key. eg, "BB".
    #
    def to_s
      @real_key
    end


    # Returns the string representation of the value. eg, "Hardback".
    #
    def to_str
      @value.to_s
    end


    private

      # Converts a Fixnum key into a String key.
      #
      def pad(key, len)
        key ? key.to_s.rjust(len, '0') : nil
      end

  end


  class CodeListNotFound < ArgumentError
    def initialize(list_number)
      @list_number = list_number
    end
  end


  class CodeNotFoundInList < RuntimeError
    def initialize(list_number, code)
      @list_number = list_number
      @code = code
    end
  end

end
