$LOAD_PATH << File.join(File.dirname(__FILE__), "..","lib")
require 'onix'

filename = File.join(File.dirname(__FILE__), "..","data","rba_FANT.xml")
msg = ONIX::Message.load_from_file(filename)
puts msg.header.inspect
puts 
msg.products.each do |p|
  puts p.best_id + " - " + p.best_title
  puts p.inspect
  puts
end
