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
        passport[$~[1].to_sym] = $~[2]
        line = line[$~[0].length...]
      end
    end
  end
  yield passport if passport != {}
end

validation_patterns = {
  :byr => /^(\d{4})$/,
  :iyr => /^(\d{4})$/,
  :eyr => /^(\d{4})$/,
  :hgt => /^(\d+)(cm|in)$/,
  :hcl => /^#[0-9a-f]{6}$/,
  :ecl => /^(amb|blu|brn|gry|grn|hzl|oth)$/,
  :pid => /^(\d{9})$/
}

def validate_range(lower, upper)
  -> (v1, v2) { v1.to_i >= lower && v1.to_i <= upper }
end

validation_fns = {
  :byr => validate_range(1920, 2002),
  :iyr => validate_range(2010, 2020),
  :eyr => validate_range(2020, 2030),
  :hgt => -> (v1, v2) {
    if v2 == "in" 
      validate_range(59, 76).(v1, v2)
    else
      validate_range(150, 193).(v1, v2)
    end
  }
}

n_valid = 0

load_passports(STDIN) do |passport|
  valid = true

  validation_patterns.each do |field, pattern|
    if !passport.key?(field) || passport[field] !~ pattern
      valid = false
      break
    end

    if validation_fns.include?(field) && !validation_fns[field].($~[1], $~[2])
      valid = false
      break
    end
  end

  n_valid += 1 if valid
end

puts n_valid
