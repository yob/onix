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
  # - uses reference tags, not short
  # - doesn't contain control characters banned by the XML spec
  #
  # Optionally, it can also rewrite the XML declaration with a new
  # encoding. This is useful when the original generator of the file left
  # the encoding indicator off or got it wrong. The encoding indicator of
  # the file *MUST* be correct for ONIX::Reader to function correctly.
  #
  # Usage:
  #
  #   ONIX::Normaliser.process("oldfile.xml", "newfile.xml")
  #   ONIX::Normaliser.process("oldfile.xml", "newfile.xml", :encoding => "iso-8859-1")
  #   ONIX::Normaliser.process("oldfile.xml", "newfile.xml", :encoding => "utf-8")
  #
  # Dependencies:
  #
  # At this stage the class depends on several external apps, all commonly available
  # on *nix systems: xsltproc, tr and sed
  #
  class Normaliser

    class << self

      # normalise oldfile and save it as newfile. oldfile
      # will be left untouched
      #
      def process(oldfile, newfile, opts = {})
        self.new(oldfile, newfile, opts).run
      end
    end

    def initialize(oldfile, newfile, opts = {})
      raise ArgumentError, "#{oldfile} does not exist" unless File.file?(oldfile)
      raise ArgumentError, "#{newfile} already exists" if File.file?(newfile)
      raise "xsltproc app not found" unless app_available?("xsltproc")
      raise "tr app not found"       unless app_available?("tr")
      raise "sed app not found"      unless app_available?("sed")
      raise "cat app not found"      unless app_available?("cat")

      @options = opts
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

      if @options[:encoding]
        dest = next_tempfile
        fix_encoding_mark(@curfile, dest, @options[:encoding])
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

    def fix_encoding_mark(src, dest, enc)
      inpath = File.expand_path(src)
      outpath = File.expand_path(dest)

      head = File.open(inpath,"r").read(512)
      decl = "<?xml version=\"1.0\" encoding=\"#{enc}\" ?>"
      if head.include?("<?xml")
        `cat #{inpath} | sed -e 's/xml[^\\?]\\+/xml version="1.0" encoding="iso-8859-1" /' > #{outpath}`
      else
        `echo '#{decl}' > #{outpath}`
        `cat #{inpath} >> #{outpath}`
      end
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
