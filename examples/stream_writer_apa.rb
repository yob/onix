$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')

require 'onix'

File.open('output.xml', "w") do |output|
  header = ONIX::Header.new
  header.from_company = "Sample Company"
  header.from_person  = "James"
  header.sent_date = Time.now

  writer = ONIX::StreamWriter.new(output, header)

  product = ONIX::APAProduct.new
  product.notification_type = 2
  product.record_reference = 1
  product.isbn10 = "1844836902"
  product.isbn13 = "9781844836901"
  product.title = "1001 Pearls of Bible Wisdom"
  product.subtitle = "Boo"
  product.supplier_website = "http://www.rainbowbooks.com.au/title/show/9781844836901"
  product.add_contributor("Healy, James")
  product.imprint = "Malhame"
  product.publisher = "Dover"
  product.sales_restriction_type = 0
  product.supplier_name = "Rainbow Book Agencies"
  product.supplier_phone = "+61 3 9481 6611"
  product.supplier_fax = "+61 3 9481 2371"
  product.supplier_email = "rba@rainbowbooks.com.au"
  product.supply_country = "AU"
  #product.on_hand = 10
  #product.on_order = 20
  #product.rrp_inc_sales_tax = 29.95

  writer << product

  writer.end_document
end
