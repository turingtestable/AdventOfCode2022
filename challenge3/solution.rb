def alphabet
  'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
end

def parse_file
  @parse_file ||= File.open('input.txt').readlines.map(&:chomp)
end

def find_repeat(line)
  chars = line.split('')
  mid = line.size / 2
  chars[0, mid].each do |char|
    if chars[mid, mid].include?(char)
      return char
    end
  end
end

def calculate_total_priority(lines)
  lines.reduce(0) { |total, line| total + alphabet.index(find_repeat(line)) + 1 }
end

def calculate_total_badge_priority(lines)
  total = 0
  (0..lines.size-3).step(3) do |n|
    lines[n].split('').each do |char|
      if lines[n + 1].include?(char) && lines[n + 2].include?(char)
        total += alphabet.index(char) + 1
        break
      end
    end
  end
  total
end

puts "solution1: #{calculate_total_priority(parse_file)}"
puts "solution2: #{calculate_total_badge_priority(parse_file)}"