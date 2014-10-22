$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')

require 'onix'

#reader = ONIX2::Reader.new(File.join(File.dirname(__FILE__),"..","data","0705NHP.XML"))
#reader = ONIX2::Reader.new(File.join(File.dirname(__FILE__),"..","data","9780194351898.xml"))
#reader = ONIX2::Reader.new(File.join(File.dirname(__FILE__),"..","data","jul.xml"))
reader = ONIX2::Reader.new(File.join(File.dirname(__FILE__),"..","bookwise.xml"))
#reader = ONIX2::Reader.new(File.join(File.dirname(__FILE__),"..","data","rba_FANT.xml"))
counter = 0

# display header info
puts reader.header.from_company
puts reader.header.sent_date
puts

reader.each do |item|
  #puts item.titles.inspect
  #puts item.subjects.inspect
  puts
  puts item
  counter += 1
end

puts "total of ##{counter} products"
