def parse_file
  @parse_file ||= File.open('input.txt').readlines.map(&:chomp).map { |n| n.split(',') }
end

def overlaps_either_direction(current)
  first = current[0].split('-')
  second = current[1].split('-')
  [overlaps(first, second), overlaps(second, first)].max
end

def completely_contains(current)
  first = current[0].split('-')
  second = current[1].split('-')
  [contains(first, second), contains(second, first)].max
end

def count_containments(assignments, containment_type)
  assignments.reduce(0) do |total, current| 
    total + method(containment_type).call(current) 
  end
end

def contains(assignment1, assignment2)
  if assignment1[0].to_i <= assignment2[0].to_i && assignment1[1].to_i >= assignment2[1].to_i
    1
  else
    0
  end
end

def overlaps(assignment1, assignment2)
  if assignment1[0].to_i <= assignment2[0].to_i && assignment1[1].to_i >= assignment2[0].to_i
    1
  else
    0
  end
end

puts "solution 1: #{count_containments(parse_file, :completely_contains)}"
puts "solution 2: #{count_containments(parse_file, :overlaps_either_direction)}"
