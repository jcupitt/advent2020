#!/usr/bin/ruby

def read_groups(input)
  group = []
  input.each_line do |line|
    line = line.chomp
    if line == ""
      yield group if group != []
      group = []
      next
    end
    group << line.chars.map(&:to_sym)
  end
  yield group if group != []
end

group_counts = []
read_groups(STDIN) do |group|
  counts = Hash.new 0
  group.each{|person| person.each{|question| counts[question] = 1}}
  group_counts << counts.values.reduce(:+)
end

puts group_counts.reduce :+
