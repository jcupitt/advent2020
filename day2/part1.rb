#!/usr/bin/ruby

n_correct = 0
STDIN.each_line do |line|
  if line !~ /(\d+)-(\d+) (.): ([a-z]+)/
    puts "bad line #{line}"
  end
  from = $~[1].to_i
  to = $~[2].to_i
  letter = $~[3]
  password = $~[4]

  n_found = password.chars.filter{ |c| c == letter }.length
  n_correct += 1 if n_found >= from && n_found <= to
end

puts n_correct
