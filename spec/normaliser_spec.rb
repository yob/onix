# coding: utf-8

require 'spec_helper'

describe ONIX::Normaliser, "with a simple short tag file" do

  Given(:filename) { File.join(File.dirname(__FILE__), "..", "data", "short_tags.xml") }
  Given(:outfile) { filename + ".new" }
  Given { File.unlink(outfile) if File.file?(outfile) }

  describe "should correctly convert short tag file to reference tag" do
    Given { ONIX::Normaliser.process(filename, outfile) }
    Then { File.file?(outfile) }

    Given(:content) { File.read(outfile) }

    Then { !content.include? "<m174>" }
    Then { content.include? "<FromCompany>" }
  end

end

# describe ONIX::Normaliser, "with a simple short tag file that has no doctype" do
#   Given(:filename) { File.join(File.dirname(__FILE__), "..", "data", "short_tags_no_doctype.xml") }
#   Given(:outfile) { filename + ".new" }
#   Given { File.unlink(outfile) if File.file?(outfile) }

#   describe "should correctly convert short tag file to reference tag" do
#     pending
#     Given { ONIX::Normaliser.process(filename, outfile) }
#     Then { File.file?(outfile) }

#     Given(:content) { File.read(outfile) }

#     Then { !content.include? "<m174>" }
#     Then { content.include? "<FromCompany>" }
#   end

# end

describe ONIX::Normaliser, "with a short tag file that include HTML tags" do

  Given(:filename) { File.join(File.dirname(__FILE__), "..", "data", "short_tags_ivp.xml") }
  Given(:outfile) { filename + ".new" }
  Given { File.unlink(outfile) if File.file?(outfile) }

  describe "should correctly convert short tag file to reference tag" do
    Given { ONIX::Normaliser.process(filename, outfile) }
    Then { File.file?(outfile) }

    Given(:content) { File.read(outfile) }

    Then { !content.include? "<m174>" }
    Then { content.include? "<FromCompany>" }
    Then { content.include? "<em>Discipleship Essentials</em>" }
  end

end

describe ONIX::Normaliser, "with a utf8 file that has illegal control chars" do

  Given(:filename) { File.join(File.dirname(__FILE__), "..", "data", "control_chars.xml") }
  Given(:outfile) { filename + ".new" }
  Given { File.unlink(outfile) if File.file?(outfile) }

  describe "should remove all control chars except LF, CR and TAB" do
    Given { ONIX::Normaliser.process(filename, outfile) }
    Then { File.file?(outfile) }

    Given(:content) { File.read(outfile) }
    Then { content.include? "<TitleText>OXFORDPICTURE DICTIONARY CHINESE</TitleText>" }
  end

end
