#!/usr/bin/ruby

input = STDIN.each_line.map(&:chomp).map(&:chars)

result = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]].map do |dx, dy|
  x = y = n_trees = 0

  while y < input.length
    n_trees += 1 if input[y][x % input[0].length] == "#"
    x += dx
    y += dy
  end

  n_trees
end.reduce(:*)

puts result
