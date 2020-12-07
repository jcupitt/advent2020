#!/usr/bin/ruby

class Bag
  include Enumerable
  attr_accessor :colour

  def initialize(colour)
    @colour = colour
    # hash from child colour name to refs to bags
    @contains_bags = {}
    # hash from child colour name to number of those bags we can hold
    @contains_numbers = {}
  end

  def inspect
    [@colour, @contains_bags, @contains_numbers].inspect
  end

  def to_s
    "<Bag #{@colour}>"
  end

  def each(&block)
    if block_given?
      @contains_bags.each_value(&block)
    else
      to_enum(:each)
    end
  end

  def contains(number, colour)
    if @contains_numbers.key? colour
      puts "duplicate contains #{colour} for #{self}"
      exit
    end

    @contains_numbers[colour] = number
  end

  def can_contain?(colour)
    @contains_numbers.key? colour
  end

  def contains_n(colour)
    @contains_numbers[colour]
  end

  def empty?
    @contains_numbers == {}
  end

  def link(child)
    if ! @contains_numbers.key? child.colour 
      puts "#{self} cannot contain #{child}"
      puts @contains_numbers.inspect
      exit
    end

    @contains_bags[child.colour] = child
  end

  def pretty(number, indent)
    if empty?
      puts "#{" " * indent}#{number} #{colour}."
    else
      puts "#{" " * indent}#{number} #{colour}, each of which contains:"
      each {|child| child.pretty(contains_n(child.colour), indent + 2)}
    end
  end

  def walk
    yield self
    each {|child| child.walk}
  end

  def contains_any?(colour)
    if @colour == colour
      return true
    else 
      each do |child|
        return true if child.contains_any? colour
      end
      return false
    end
  end

  def contains_n_all(colour)
    if @colour == colour
      return 1
    else 
      return reduce(0) do |n, child|
        n + contains_n(child.colour) * child.contains_n_all(colour)
      end
    end
  end

end

# parse phase
all_bags = {}
STDIN.each_line do |line|
  line = line.chomp

  if line !~ /^(\w+ \w+) bags contain /
    puts "bad line: #{line}"
    exit
  end
  line = line[$~[0].length ..]
  colour = $~[1]
  all_bags[colour] = bag = Bag.new(colour)

  while line =~ /^(\d+) (\w+ \w+) bags?[,.][ ]?/
    line = line[$~[0].length ..]
    bag.contains($~[1].to_i, $~[2])
  end

  if line != "no other bags." && line != ""
    puts "unparsed input: #{line}"
    exit
  end
end

# link phase
all_bags.each do |outer_colour, outer_bag|
  all_bags.each do |inner_colour, inner_bag|
    if outer_bag.can_contain? inner_colour
      outer_bag.link(inner_bag)
    end
  end
end

# search phase
n_can_contain = 0
all_bags.each do |colour, bag|
  if colour != "shiny gold"
    n_can_contain += 1 if bag.contains_any? "shiny gold"
  end
end

puts "#{n_can_contain} bags can eventually contain at least one shiny gold"

