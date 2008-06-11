$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')

require 'onix'

reader = ONIX::StreamReader.new(File.join(File.dirname(__FILE__),"..","data","jul.xml"))
#reader = ONIX::StreamReader.new(File.join(File.dirname(__FILE__),"..","data","rba_FANT.xml"))
counter = 0

reader.each do |product|
  puts product.best_id
  counter += 1
end

puts "total of ##{counter} products"
