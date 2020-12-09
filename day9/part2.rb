#!/usr/bin/ruby

target = ARGV[0].to_i
numbers = STDIN.each_line.map(&:to_i)

(0 .. numbers.length).each do |i|
  sum = 0
  (i .. numbers.length).each do |j|
    sum += numbers[j]
    if sum == target
      window = numbers[i .. j]
      puts "found #{window}"
      puts "min plus max == #{window.min + window.max}"
      exit
    elsif sum > target
      break
    end
  end
end
