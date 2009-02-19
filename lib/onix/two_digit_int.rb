
module ONIX

  class TwoDigitInt
    def self.from_xml(val)
      new(val.content.to_i)
    end

    def initialize(value)
      @val = value
    end

    def ==(other)
      @val == other
    end

    def to_xml
      if @val < 10
        "0#{@val}"
      elsif @val > 99
        @val.to_s[-2,2]
      else
        @val.to_s
      end
    end

  end
end

