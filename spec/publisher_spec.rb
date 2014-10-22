# coding: utf-8

require 'spec_helper'

describe ONIX2::Publisher do

  Given(:doc) { load_xml "publisher.xml" }

  describe "should correctly convert to a string" do
    Given(:pub) { ONIX2::Publisher.from_xml(doc) }
    Then { pub.to_xml.to_s.start_with? "<Publisher>" }
  end

  describe "should provide read access to first level attributes" do
    Given(:pub) { ONIX2::Publisher.from_xml(doc) }

    Then { pub.publishing_role == 1 }
    Then { pub.publisher_name == "Desbooks Publishing" }
  end

  context "should provide write access to first level attributes" do
    Given(:pub) { ONIX2::Publisher.new }
    describe :publisher_name= do
      When { pub.publisher_name = "Paulist Press" }
      Then { pub.to_xml.to_s.include? "<PublisherName>Paulist Press</PublisherName>" }
    end
    describe :publishing_role= do
      When { pub.publishing_role = 2 }
      Then { pub.to_xml.to_s.include? "<PublishingRole>02</PublishingRole>" }
    end
  end

end
