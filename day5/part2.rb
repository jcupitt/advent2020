#!/usr/bin/ruby

seat_map = Array.new(832){0}

STDIN.map do |line|
  id = line[..9].chars.
    map{|x| (x == "F" || x == "L") ? 0 : 1}.reduce{|s, x| s << 1 | x}
  seat_map[id] = 1
end

(1 ... seat_map.length).each do |id|
  if seat_map[id - 1] == 1 && 
    seat_map[id] == 0 && 
    seat_map[id + 1] == 1
    puts id
  end
end


