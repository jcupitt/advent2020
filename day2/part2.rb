#!/usr/bin/ruby

n_correct = 0
STDIN.each_line do |line|
  line !~ /(\d+)-(\d+) (.): ([a-z]+)/
  f994454-bffc0b14irst = $~[1].to_i - 1
  second = $~[2].to_i - 1
  letter = $~[3]
  password = $~[4].chars

  if (password[first] == letter && password[second] != letter) ||
    (password[first] != letter && password[second] == letter)
    n_correct += 1
  end
end

puts n_correct
