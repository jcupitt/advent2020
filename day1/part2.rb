#!/usr/bin/ruby

values = STDIN.each_line.map(&:to_i)

(0 ... values.length).each do |i|
  (i + 1 ... values.length).each do |j|
    (j + 1 ... values.length).each do |k|
      if values[i] + values[j] + values[k] == 2020
        puts values[i] * values[j] * values[k]
      end
    end
  end
end
