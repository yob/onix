$LOAD_PATH << File.join(File.dirname(__FILE__), "..","lib")

require 'onix'

filename = File.join(File.dirname(__FILE__), "..","data","jul.xml")

msg = ONIX::Message.load_from_file(filename)
puts msg.header.inspect
puts 
puts "#{msg.products.size} products"
puts
msg.products.each do |p|
  puts p.inspect
end
