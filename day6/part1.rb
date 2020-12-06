#!/usr/bin/ruby

require "set"

# yield an array of sets for each group, eg.
# [#<Set: {"c", "t"}>, #<Set: {"c", "q"}>]
def read_groups(input)
  group = []
  input.each_line do |line|
    line = line.chomp
    if line == ""
      yield group if group != []
      group = []
      next
    end
    group << Set.new(line.chars)
  end
  yield group if group != []
end

counts = 0
read_groups(STDIN) do |group|
  counts += group.reduce(:|).length
end

puts counts
