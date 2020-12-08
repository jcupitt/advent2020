#!/usr/bin/ruby

program = STDIN.each_line.map do |line|
  if line !~ /^(\w+) ([+-]\d+)/
    puts "bad instruction #{line}"
    exit
  end
  [$~[1].to_sym, $~[2].to_i]
end

puts "#{program.length} instructions"

def interpret(program, visited, frozen, pc, acc)
  loop do
    if pc < 0 
      puts "pc < 0"
      exit
    end
    if pc == program.length
      return [:ok, pc, acc]
    end
    if pc > program.length
      puts "pc > end"
      exit
    end
    if visited[pc] 
      return [:revisited, pc, acc]
    end
    visited[pc] = true
    op, arg = program[pc]

    case op
    when :acc
      acc += arg
      pc += 1

    when :nop
      # attempt execution with this as a jmp
      if ! frozen
        result = interpret(program, visited.clone, true, pc + arg, acc)
        return result if result[0] == :ok
      end

      # nope, stick with nop
      pc += 1

    when :jmp
      # attempt execution with this as a nop
      if ! frozen
        result = interpret(program, visited.clone, true, pc + 1, acc)
        return result if result[0] == :ok
      end

      # nope, stick with a jmp
      pc += arg

    else
      puts "bad opcode #{op}"
      exit
    end
  end
end

result = interpret(program, Array.new(program.length, false), false, 0, 0)

puts "result = #{result}"
