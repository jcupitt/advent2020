#!/usr/bin/ruby

values = STDIN.each_line.map(&:to_i)

(0 ... values.length).each do |i|
  (i + 1 ... values.length).each do |j|
    if values[i] + values[j] == 2020
      puts values[i] * values[j]
    end
  end
end
