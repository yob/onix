$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')

require 'onix'

File.open('output.xml', "w") do |output|
  header = ONIX::Header.new
  header.from_company = "Sample Company"
  header.from_person  = "James"

  writer = ONIX::StreamWriter.new(output, header)

  product = ONIX::APAProduct.new
  product.notification_type = 2
  product.record_reference = 1
  product.isbn10 = "1844836902"
  product.isbn13 = "9781844836901"
  product.title = "1001 Pearls of Bible Wisdom"
  product.subtitle = "Boo"

  writer << product

  writer.end_document
end
