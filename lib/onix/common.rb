module ONIX
  module Common
    def after_parse
      self.class.roxml_attrs.each do |attr|
        var = instance_variable_get("@#{attr.variable_name}")
        if var && var.respond_to?(:force_encoding)
          var.force_encoding("utf-8")
        end
      end
    end
  end
end

