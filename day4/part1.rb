#!/usr/bin/ruby

n_valid = 0
entries = {}
STDIN.each_line do |line|
  if line != "\n"
    while line =~ /([a-z]+):([^ ]+)/
      entries[$~[1]] = $~[2].chomp
      line = line[$~[0].length...]
    end
  else
    puts "entries = #{entries}"
    puts "length = #{entries.length}, cid = #{entries.include?("cid")}"
    if entries.length == 8 || 
      (entries.length == 7 && !entries.include?("cid"))
      n_valid += 1
      puts "valid"
    end
    entries = {}
  end
end

puts n_valid
