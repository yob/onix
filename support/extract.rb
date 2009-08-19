#!/usr/bin/env ruby1.9

#
# A small script to extract entities from the ONIX DTD
#
# USAGE: ./extract <dir>
#
# Where dir is a directory containing an ONIX 2.1r3 DTD.
#

unless File.directory?(ARGV.first)
  $stderr.puts "directory doesn't exist"
  exit(1)
end

Dir.entries(ARGV.first).each do |f|
  next unless f[-4,4] == ".ent"

  content = File.binread(ARGV.first + "/" + f)
  content.scan(/ENTITY [a-zA-Z0-9]+.*"\&#x.+;/).each do |str|
    m, name, numeric = *str.match(/ENTITY ([a-zA-Z0-9]+).*"\&([^;]+);/)
    puts "#{name}:#{numeric}"
  end

end
