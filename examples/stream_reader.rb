$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')

require 'onix'

reader = ONIX::StreamReader.new(File.join(File.dirname(__FILE__),"..","data","9780194351898.xml"))
#reader = ONIX::StreamReader.new(File.join(File.dirname(__FILE__),"..","data","jul.xml"))
#reader = ONIX::StreamReader.new(File.join(File.dirname(__FILE__),"..","data","rba_FANT.xml"))
counter = 0

reader.each do |item|
  case item
  when ONIX::Header
    puts "From: #{item.from_company}"
  else
    puts item.subjects.inspect
    counter += 1
  end
  puts
end

puts "total of ##{counter} products"
