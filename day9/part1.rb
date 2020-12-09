#!/usr/bin/ruby

window_size = ARGV[0].to_i
numbers = STDIN.each_line.map(&:to_i)

def window_contains?(window, target)
  (0 ... window.length).each do |i|
    (i ... window.length).each do |j|
      return true if window[i] + window[j] == target
    end
  end
  false
end

(window_size ... numbers.length).each do |i|
  target = numbers[i]
  if ! window_contains?(numbers[i - window_size ... i], target)
    puts "#{target} at line #{i} is not the sum of a pair in the previous #{window_size}"
  end
end
