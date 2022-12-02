values = {
  "A X": 4,
  "A Y": 8,
  "A Z": 3,
  "B X": 1,
  "B Y": 5,
  "B Z": 9,
  "C X": 7,
  "C Y": 2,
  "C Z": 6
}

values2 = {
  "A X": 3,
  "A Y": 4,
  "A Z": 8,
  "B X": 1,
  "B Y": 5,
  "B Z": 9,
  "C X": 2,
  "C Y": 6,
  "C Z": 7
}

def parse_file
  @parse_file ||= File.open('input.txt').readlines.map(&:chomp)
end

def total_value(input, strategy)
  input.reduce(0) { |total, line| total + strategy[line.to_sym] }
end

puts "solution1: #{total_value(parse_file, values)}"
puts "solution2: #{total_value(parse_file, values2)}"
