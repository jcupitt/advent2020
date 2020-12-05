#!/usr/bin/ruby

highest = STDIN.map do |line|
  line[..9].chars.
    map{|x| (x == "F" || x == "L") ? 0 : 1}.reduce{|s, x| s << 1 | x}
end.max

puts highest

