# coding: utf-8

require 'tempfile'
require 'fileutils'

module ONIX

  # A standalone class that can be used to normalise ONIX files
  # into a standardised form. If you're accepting ONIX files from a wide range
  # of suppliers, you're guarunteed to get all sorts of dialects.
  #
  # This will create a new file that:
  #
  # - is UTF-8 encoded
  # - uses reference tags, not short
  # - has no named entities (ndash, etc) other than &amp; &lt; and &gt;
  #
  # Usage:
  #
  #   ONIX::Normaliser.process("oldfile.xml", "newfile.xml")
  #   
  # Dependencies:
  #
  # At this stage the class depends on several external apps, all commonly available
  # on *nix systems: xsltproc, isutf8, iconv and sed
  #
  class Normaliser

    class << self

      # normalise oldfile and save it as newfile. oldfile
      # will be left untouched
      #
      def process(oldfile, newfile)
        self.new(oldfile, newfile).run
      end
    end

    def initialize(oldfile, newfile)
      raise ArgumentError, "#{oldfile} does not exist" unless File.file?(oldfile)
      raise ArgumentError, "#{newfile} already exists" if File.file?(newfile)
      raise "xsltproc app not found" unless app_available?("xsltproc")
      raise "tr app not found"       unless app_available?("tr")

      @oldfile = oldfile
      @newfile = newfile
      @curfile = next_tempfile
      FileUtils.cp(@oldfile, @curfile)
      @head    = File.open(@oldfile, "r") { |f| f.read(1024) }
    end

    def run
      # remove short tags
      if @head.include?("ONIXmessage")
        dest = next_tempfile
        to_reference_tags(@curfile, dest)
        @curfile = dest
      end

      # remove control chars
      dest = next_tempfile
      remove_control_chars(@curfile, dest)
      @curfile = dest

      FileUtils.cp(@curfile, @newfile)
    end

    #private

    # check the specified app is available on the system
    #
    def app_available?(app)
      `which #{app}`.strip == "" ? false : true
    end

    # generate a temp filename
    #
    def next_tempfile
      p = nil
      Tempfile.open("onix") do |tf|
        p = tf.path
        tf.close!
      end
      p
    end

    # uses an XSLT stylesheet provided by edituer to convert
    # a file from short tags to long tags.
    #
    # more detail here:
    #   http://www.editeur.org/files/ONIX%203/ONIX%20tagname%20converter%20v2.htm
    #
    def to_reference_tags(src, dest)
      inpath = File.expand_path(src)
      outpath = File.expand_path(dest)
      xsltpath = File.dirname(__FILE__) + "/../../support/switch-onix-2.1-short-to-reference.xsl"
      `xsltproc -o #{outpath} #{xsltpath} #{inpath}`
    end

    # XML files shouldn't contain low ASCII control chars. Strip them.
    #
    def remove_control_chars(src, dest)
      inpath = File.expand_path(src)
      outpath = File.expand_path(dest)
      `cat #{inpath} | tr -d "\\000-\\010\\013\\014\\016-\\037" > #{outpath}`
    end

  end

end
