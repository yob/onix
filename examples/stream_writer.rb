$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')

require 'onix'

File.open('output.xml', "w") do |output|
  header = ONIX::Header.new
  header.from_company = "Sample Company"
  header.from_person  = "James"

  writer = ONIX::StreamWriter.new(output, header)

  writer.end_document
end
