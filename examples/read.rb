$LOAD_PATH << File.join(File.dirname(__FILE__), "..","lib")

require 'onix'

filename = File.join(File.dirname(__FILE__), "..","data","9780194351898.xml")

msg = ONIX::Message.parse(File.read(filename))
puts msg.header.inspect
puts 
puts "#{msg.products.size} products"
puts
msg.products.each do |p|
  puts p.inspect
end
