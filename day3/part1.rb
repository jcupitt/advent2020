#!/usr/bin/ruby

input = STDIN.each_line.map(&:chomp).map(&:chars)

x = y = n_trees = 0

while y < input.length
  n_trees += 1 if input[y][x % input[0].length] == "#"
  x += 3
  y += 1
end

puts n_trees
