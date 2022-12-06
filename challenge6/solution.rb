def parse_file
  @parse_file ||= File.open('input.txt').readlines.map(&:chomp)[0]
end

def detect_starting_code(line)
  (0..line.length-3).each do |n|
    return n + 3 + 1 unless any_pairs?(line, n)
  end
end

def any_pairs?(line, n)
  line[n] == line[n + 1] ||
    line[n] == line[n + 2] ||
    line[n] == line[n + 3] ||
    line[n + 1] == line[n + 2] ||
    line[n + 1] == line[n + 3] ||
    line[n + 2] == line[n + 3]
end

puts "solution 1: #{detect_starting_code(parse_file)}"
