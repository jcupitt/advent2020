#!/usr/bin/ruby

program = STDIN.each_line.map do |line|
  if line !~ /^(\w+) ([+-]\d+)/
    puts "bad instruction #{line}"
    exit
  end
  [$~[1].to_sym, $~[2].to_i]
end

puts "#{program.length} instructions"

pc = 0
acc = 0
visited = Array.new(program.length, false)
loop do
  break if pc < 0 || pc >= program.length || visited[pc] 
  visited[pc] = true
  op, arg = program[pc]

  case op
  when :acc
    acc += arg
    pc += 1

  when :nop
    pc += 1

  when :jmp
    pc += arg

  else
    puts "bad opcode #{op}"
    exit
  end
end

puts "pc = #{pc}"
puts "acc = #{acc}"
