# coding: utf-8


module ONIX

  class Code

    attr_reader :key, :value

    # Note re: key type. For backwards compatibility, code keys that are
    # all-digits are passed around in this gem as Fixnums.
    #
    # The actual code list hashes have string-based keys for consistency. If
    # you want the integer-or-string key, use Code#key. If you want the real
    # string key, use Code#to_s.
    #
    def initialize(codelist_number, data, options = {})
      unless @list = ONIX::Lists.list(codelist_number)
        raise "No ONIX codelist for number: #{codelist_number}"
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
          @key = @real_key = k
          break
        }
      end
      @value = @list[@real_key]  if @real_key


      unless @real_key
        raise ArgumentError, "Invalid data (key or value): '#{data}'. " +
          "Refer to ONIX Code List #{codelist_number}"
      end
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
        if key.nil?
          ''
        elsif key >= 0 && key < 10**len
          sprintf("%0#{len}d", key)
        else
          raise ArgumentError, "List key '#{key}' " +
            "does not conform to #{len}-digit restrictions"
        end
      end

  end

end
