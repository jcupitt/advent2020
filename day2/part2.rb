#!/usr/bin/ruby

n_correct = 0
STDIN.each_line do |line|
  line !~ /(\d+)-(\d+) (.): ([a-z]+)/
  first = $~[1].to_i - 1
  second = $~[2].to_i - 1
  letter = $~[3]
  password = $~[4].chars

  n_correct += 1 if (password[first] == letter) ^ (password[second] == letter)
end

puts n_correct
