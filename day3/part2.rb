#!/usr/bin/ruby

input = STDIN.each_line.map(&:chomp)

result = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]].map do |dx, dy|
  (0 ... input.length).step(dy).zip((0 ...).step(dx)).map do |y, x|
    input[y][x % input[0].length]
  end.
    filter{|ch| ch == "#"}.
    count
end.reduce(:*)

puts result
