$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')

require 'onix'

reader = ONIX::Reader.new(File.join(File.dirname(__FILE__),"..","data","9780194351898.xml"))
#reader = ONIX::Reader.new(File.join(File.dirname(__FILE__),"..","data","jul.xml"))
#reader = ONIX::Reader.new(File.join(File.dirname(__FILE__),"..","data","rba_FANT.xml"))
counter = 0

# display header info
puts reader.header.from_company

reader.each do |item|
  puts item.inspect
  puts
  counter += 1
end

puts "total of ##{counter} products"
