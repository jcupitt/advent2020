#!/usr/bin/ruby

input = STDIN.each_line.map(&:chomp)

n_trees = input.
  each_with_index.
  map{|x, i| x[i * 3 % input[0].length]}.
  filter{|x| x == "#"}.
  count

puts n_trees
