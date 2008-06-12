$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')

require 'onix'

reader = ONIX::StreamReader.new(File.join(File.dirname(__FILE__),"..","data","jul.xml"))
#reader = ONIX::StreamReader.new(File.join(File.dirname(__FILE__),"..","data","rba_FANT.xml"))
counter = 0

reader.each do |product|
  #puts product.inspect
  puts product.cover_image
  puts
  counter += 1
end

puts "total of ##{counter} products"
