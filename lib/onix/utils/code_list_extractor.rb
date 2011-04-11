# coding: utf-8

module ONIX

  # A utility class that processes the code list XSD from the ONIX spec and
  # creates a set of TSV files. The generated files are used by this library
  # to make hashes of the code lists available to users.
  #
  class CodeListExtractor

    # Creates a new extractor. Expects the path to a copy of the code lists
    # file from the spec (called ONIX_BookProduct_CodeLists.xsd on my system).
    #
    def initialize(filename)
      raise ArgumentError, "#{filename} not found" unless File.file?(filename)

      @filename = filename
    end

    # generate a set of TSV files in the given directory. Creates the directory
    # if it doesn't exist and will overwrite existing files.
    #
    def run(dir)
      FileUtils.mkdir_p(dir) unless File.directory?(dir)

      each_list do |number, data|
        #puts number
        file = number.to_s.rjust(3, "0") + ".tsv"
        path = File.join(dir, file)
        File.open(path, "w") { |f| f.write data}
      end
    end

    private

    def data
      @data ||= File.open(@filename) { |f| f.read }
    end

    def document
      @document ||= Nokogiri::XML(data)
      @document.remove_namespaces! if @document.namespaces.size > 0
      @document
    end

    def each_list(&block)
      document.xpath("//simpleType").each do |node|
        list_name   = node.xpath("./@name").first.value
        list_number = list_name[/List(\d+)/,1].to_i
        if list_number > 0
          yield list_number, list_data(list_number)
        end
      end
    end

    def list_data(num)
      str   = ""
      nodes = document.xpath("//simpleType[@name='List#{num}']/restriction/enumeration")
      nodes.each do |node|
        code  = node.xpath("./@value").first.value
        desc  = node.xpath("./annotation/documentation").first.text
        ldesc = node.xpath("./annotation/documentation").last.text
        str += "#{code}\t#{desc}\t#{ldesc}\n"
      end
      str
    end

  end
end
