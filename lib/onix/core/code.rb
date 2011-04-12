# coding: utf-8


module ONIX

  class Code

    attr_reader :key, :value

    def initialize(codelist_number, value, options = {})
      unless @list = ONIX::Lists.list(codelist_number)
        raise "No ONIX codelist for number: #{codelist_number}"
      end
      @key = @value = nil
      unless value.nil? || value == ""
        if @list.keys.include?(value)
          @key = value
          @value = @list[@key]
        elsif value.match(/^\d+$/) && @list.keys.include?(value.to_i)
          @key = value.to_i
          @value = @list[@key]
        else
          @list.each_pair { |k, v|
            next  unless v == value
            @key = k
            break
          }
        end
        @value = @list[@key]  if @key

        @length = options[:length] || ["#{@list.size}".size, 2].max

        unless @key
          raise ArgumentError, "Invalid value: '#{value}'. " +
            "Refer to ONIX Code List #{codelist_number}"
        end
      end
    end


    def to_s
      return @key  unless @key.kind_of?(Fixnum)
      if @key.nil?
        ''
      elsif @key >= 0 && @key < 10**@length
        sprintf("%0#{@length}d", @key)
      else
        raise ArgumentError, "List key '#{@key}' " +
          "does not conform to #{@length}-digit restrictions"
      end
    end


    def to_str
      @value.to_s
    end

  end

end
