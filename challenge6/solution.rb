def parse_file
  @parse_file ||= File.open('input.txt').readlines.map(&:chomp)[0]
end

def detect_starting_code(line, size)
  (0..line.length-3).each do |n|
    return n + size unless any_pairs?(line, n, size)
  end
end

def any_pairs?(line, n, size)
  potential_message = line[n..n + size - 1]
  potential_message.length != potential_message.split('').uniq.length
end

puts "solution 1: #{detect_starting_code(parse_file, 4)}"
puts "solution 2: #{detect_starting_code(parse_file, 14)}"
