#!/usr/bin/ruby

ids = STDIN.map do |line|
  line[..9].chars.reduce(0){|s, x| s << 1 | ((x == "B" || x == "R") ? 1 : 0)}
end

puts ids.max
