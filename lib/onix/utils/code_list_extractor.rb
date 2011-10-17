# coding: utf-8

module ONIX

  # A utility class that processes the code list XSD from the ONIX spec and
  # creates a set of TSV files. The generated files are used by this library
  # to make hashes of the code lists available to users.
  #
  class CodeListExtractor

    FORMATS = [:tsv, :ruby]

    # Creates a new extractor. Expects the path to a copy of the code lists
    # file from the spec (called ONIX_BookProduct_CodeLists.xsd on my system).
    #
    def initialize(filename, format = :tsv)
      raise ArgumentError, "#{filename} not found" unless File.file?(filename)

      @filename = filename
      raise "Unknown format: #{format}"  unless FORMATS.include?(format)
      @format = format
    end

    # Generate one file for each list in the specified format in the given
    # directory. Creates the directory if it doesn't exist. This will
    # overwrite any existing files.
    #
    def run(dir)
      FileUtils.mkdir_p(dir)

      each_list do |number, data|
        send("write_to_#{@format}_format", dir, number, data)
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
      nodes = document.xpath("//simpleType[@name='List#{num}']/restriction/enumeration")
      nodes.inject([]) do |arr, node|
        code  = node.xpath("./@value").first.value
        desc  = node.xpath("./annotation/documentation").first.text
        ldesc = node.xpath("./annotation/documentation").last.text
        arr.tap { |a| a << [code, desc, ldesc] }
      end
    end

    def write_to_tsv_format(dir, number, data)
      file = number.to_s.rjust(3, "0") + ".tsv"
      path = File.join(dir, file)
      out = data.collect { |row| row.join("\t") }.join("\n")
      File.open(path, "w") { |f| f.write out }
    end

    def write_to_ruby_format(dir, number, data)
      list_num = number.to_s.rjust(3, "0")
      file = list_num + ".rb"
      path = File.join(dir, file)
      str2str = lambda { |str|
        str.gsub!("\342\200\230", "'")
        str.gsub!("\342\200\231", "'")
        str.gsub!("\342\200\234", '"')
        str.gsub!("\342\200\235", '"')
        str.gsub!(/"/, '\"')
        "\"#{str}\""
      }
      # An alternative format: two-dimensional array. More complete,
      # but less addressable.
      #
      # out = ["# coding: utf-8"]
      # out << "module ONIX; module CodeLists"
      # out << "  LIST_#{number} = ["
      # out += data.collect { |row|
      #   row = row.collect { |f| "      #{str2str.call(f)}" }
      #   "    [\n#{row.join(",\n")}\n    ]"
      # }.join(",\n")
      # out << "  ]"
      # out << "end; end"
      out = ["# coding: utf-8\n"]
      out << "module ONIX; module CodeLists"
      out << "  LIST_#{number} = {"
      out << data.collect { |row|
        "    #{str2str.call(row[0])} => #{str2str.call(row[1])}"
      }.join(",\n")
      out << "  }"
      out << "end; end"
      File.open(path, "w") { |f| f.write out.join("\n") }
    end

  end
end
