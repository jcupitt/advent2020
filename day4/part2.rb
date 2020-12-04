#!/usr/bin/ruby

def valid(passport)
  passport.length == 8 || 
    (passport.length == 7 && !passport.include?("cid"))
end

n_valid = 0
passport = {}
STDIN.each_line do |line|
  line = line.chomp
  if line == ""
    n_valid += 1 if valid(passport)
    passport = {}
  else
    while line =~ /([a-z]+):([^ ]+)( +)?/
      passport[$~[1]] = $~[2]
      line = line[$~[0].length...]
    end
  end
end
if passport != {}
  n_valid += 1 if valid(passport)
end

puts "valid = #{n_valid}"
