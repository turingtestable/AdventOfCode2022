def parse_file
  @parse_file ||= File.open('input.txt').readlines.map(&:chomp)
end

def calculate_single_max(values)
  max = current_elf = 0
  values.each do |value|
    if value.empty?
      max = [max, current_elf].max
      current_elf = 0
    else
      current_elf += value.to_i
    end
  end
  max
end

def calculate_top3_max(values)
  maxes = []
  current_elf = 0
  values.each do |value|
    if value.empty?
      maxes.push(current_elf)
      current_elf = 0
    else
      current_elf += value.to_i
    end
  end
  maxes.sort.reverse[0..2].sum
end

puts "solution 1:  #{calculate_single_max(parse_file)}"
puts "solution 2: #{calculate_top3_max(parse_file)}"