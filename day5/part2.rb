#!/usr/bin/ruby

require "set"

seat_map = STDIN.map do |line|
  line[..9].chars.
    map{|x| (x == "F" || x == "L") ? 0 : 1}.reduce{|s, x| s << 1 | x}
end

puts (seat_map.min .. seat_map.max).to_set - seat_map.to_set
