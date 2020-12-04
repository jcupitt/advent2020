#!/usr/bin/ruby

$validation_patterns = {
  "byr" => /(\d{4})/,
  "iyr" => /(\d{4})/,
  "eyr" => /(\d{4})/,
  "hgt" => /(\d+)(cm|in)/,
  "hcl" => /#[0-9a-f]{6}/,
  "ecl" => /(amb|blu|brn|gry|grn|hzl|oth)/,
  "pid" => /(\d{9})/
}

def validate_range(lower, upper)
  def check(v1, v2)
    puts "in range check"
    v1.to_i >= lower && v1.to_i <= upper
  end
end

def validate_height
  def check(v1, v2)
    puts "in height check"
    if v2 == "in"
      fn = validate_range(59, 76)
      fn(v1, v2)
    else
      fn = validate_range(150, 193)
      fn(v1, v2)
    end
  end
end

$validation_fns = {
  "byr" => validate_range(1920, 2002),
  "iyr" => validate_range(2010, 2020),
  "eyr" => validate_range(2020, 2030),
  "hgt" => validate_height
}

def valid(passport)
  valid = true
  puts "passport = #{passport}"
  $validation_patterns.each do |key, pattern|
    if ! passport.key? key
      puts "passport does not include #{key}"
      valid = false
    else
      if passport[key] !~ pattern
        puts "passport value #{passport[key]} does not match #{pattern}"
        valid = false
      else
        if $validation_fns.include?(key)
          fn = $validation_fns[key]
          puts "checking #{key}.."
          if !fn($~[1], $~[2])
            valid = false
          end
        end
      end
    end
  end

  valid
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
