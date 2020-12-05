#!/usr/bin/ruby

require "set"

seat_map = Set.new

STDIN.map do |line|
  seat_map.add line[..9].chars.
    map{|x| (x == "F" || x == "L") ? 0 : 1}.reduce{|s, x| s << 1 | x}
end

puts Set.new(seat_map.min .. seat_map.max) - seat_map
