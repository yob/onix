# coding: utf-8

module ONIX
  class AudienceRange
    include ROXML

    xml_name "AudienceRange"

    xml_accessor :audience_range_qualifier, :from => "AudienceRangeQualifier", :as => Fixnum, :to_xml => ONIX::Formatters.two_digit
    xml_accessor :audience_range_precisions, :from => "AudienceRangePrecision", :as => [Fixnum] , :to_xml => [ONIX::Formatters.two_digit]
    xml_accessor :audience_range_values, :from => "AudienceRangeValue", :as => [Fixnum] , :to_xml => [ONIX::Formatters.two_digit]
    
    def initialize
      self.audience_range_precisions = []
      self.audience_range_values = []
    end

    # Returns an XML object representing this object
    def to_xml(params = {})
      params.reverse_merge!(:name => self.class.tag_name, :namespace => self.class.roxml_namespace)
      params[:namespace] = nil if ['*', 'xmlns'].include?(params[:namespace])
      XML.new_node([params[:namespace], params[:name]].compact.join(':')).tap do |root|
        refs =  (self.roxml_references.present? \
                 ? self.roxml_references \
                 : self.class.roxml_attrs.map {|attr| attr.to_ref(self) })


        refs[0].update_xml(root, refs[0].to_xml(self))  #:audience_range_qualifier

        if refs[1] #:audience_range_precisions
          refs[1].to_xml(self).each_with_index do |r, i|
            refs[1].update_xml(root, [refs[1].to_xml(self)[i]] )
            refs[2].update_xml(root, [refs[2].to_xml(self)[i]] )
          end
        end
      end
    end
  end

end
