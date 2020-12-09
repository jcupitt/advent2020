#!/usr/bin/ruby

target = ARGV[0].to_i
numbers = STDIN.each_line.map(&:to_i)

# SqueegyTBS' "inchworm" algorithm: move the head and tail forward separately,
# maintaining a running total
total = first = last = 0
while total != target
  if total < target
    total += numbers[last]
    last += 1
  else
    total -= numbers[first]
    first += 1
  end
end

sequence = numbers[first .. last]
puts "found #{sequence}"
puts "min + max == #{sequence.min + sequence.max}"
