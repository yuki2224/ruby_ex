# -*- coding: utf-8 -*-

test = {
  :ha01 => "hashval01",
  :ha02 => "hashval02",
  :ha03 => "hashval03",
  :ha04 => "hashval04"
}

puts test.include?(:ha01)
puts test[:ha01]

test.delete(:ha01)

if test.include?(:ha01) then
  puts test[:ha01]
else
  puts "no data"
end
