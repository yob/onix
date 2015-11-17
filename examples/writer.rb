$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')

require 'onix'

File.open('output.xml', "w") do |output|
  header = ONIX2::Header.new
  header.from_company = "Sample Company"
  header.from_person  = "James"

  writer = ONIX2::Writer.new(output, header)

  writer.end_document
end
