$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')

require 'onix'

reader = ONIX::StreamReader.new(File.join(File.dirname(__FILE__),"..","data","jul.xml"), ::ONIX::APAProduct)
#reader = ONIX::StreamReader.new(File.join(File.dirname(__FILE__),"..","data","rba_FANT.xml"))
counter = 0

reader.each do |product|
  #puts "#{product.record_reference} - #{product.isbn13 || product.isbn10} - #{product.title}"
  puts "#{product.record_reference} - #{product.cover_url}"
  puts
  counter += 1
end

puts "total of ##{counter} products"
