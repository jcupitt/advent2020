#!/usr/bin/ruby

def load_passports(input)
  passport = {}
  input.each_line do |line|
    line = line.chomp
    if line == ""
      yield passport
      passport = {}
    else
      while line =~ /([a-z]+):([^ ]+)( +)?/
        passport[$~[1]] = $~[2]
        line = line[$~[0].length...]
      end
    end
  end
  yield passport if passport != {}
end

n_valid = 0
load_passports(STDIN) do |passport|
  if passport.length == 8 || 
    (passport.length == 7 && !passport.include?("cid"))
    n_valid += 1
  end
end

puts n_valid
