def parse_file
  @parse_file ||= File.open('input.txt').readlines.map(&:chomp)
end

def determine_final_piles(lines, crane_type)
  split = lines.index('')
  run_instructions(lines[split+1..], process_stacks(lines[0..split]), crane_type)
end

def run_instructions(instructions, stacks, crane_type)
  instructions.each do |instruction|
    instruction_parts = instruction.split(' from ')
    direction = instruction_parts[1].split(' to ')
    stacks = method(crane_type).call(instruction_parts[0][5..].to_i, direction[0].to_i, direction[1].to_i, stacks)
  end
  stacks.each do |stack|
    print(stack.pop)
  end
end

def apply_instruction9000(amount, from, to, stacks)
  amount.times do
    stacks[to - 1].push(stacks[from - 1].pop)
  end
  stacks
end

def apply_instructions9001(amount, from, to, stacks)
  stacks[to - 1] += stacks[from - 1].slice!(amount * -1..)
  stacks
end

def process_stacks(input)
  stacks = Array.new(input[0].length / 4 + 1).map { [] }
  input.each do |line|
    (0..line.size - 1).step(4) do |pos|
      stacks[pos / 4].push(line[pos + 1]) unless line[pos] == ' '
    end
  end
  stacks.map(&:reverse)
end

print('Solution 1: ')
determine_final_piles(parse_file, :apply_instruction9000)
puts

print('Solution 2: ')
determine_final_piles(parse_file, :apply_instructions9001)
puts
