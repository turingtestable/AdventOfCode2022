class Filenode
  attr_reader :name, :type, :parent, :children

  def initialize(name, type, parent)
    @name = name
    @type = type
    @parent = parent
    @children = {}
  end

  def add_child(child)
    @children[child.name] = child
  end

  def memory_footprint(memory = 0)
    @memory_footprint ||= type == 'dir' ? children.values.reduce(0) { |total, child| total + child.memory_footprint } : memory
  end

  def find_sum_small
    my_node_value = memory_footprint > 100_000 || type == 'file' ? 0 : memory_footprint
    children.values.reduce(my_node_value) { |total, child| total + child.find_sum_small }
  end

  def find_smallest_deletion(needed_size)
    deletion_value = type == 'file' || memory_footprint < needed_size ? 70_000_000 : memory_footprint
    children.each_value { |child| deletion_value = [deletion_value, child.find_smallest_deletion(needed_size)].min }
    deletion_value
  end

  def to_s
    "#{type} #{name} #{memory_footprint} parent: #{parent.nil? ? 'WHAT WHAT' : parent.name }"
  end
end

def parse_file
  @parse_file ||= File.open('input.txt').readlines.map(&:chomp)
end

def build_tree(lines)
  current_filenode = nil
  lines.each do |line|
    if line == "$ cd /"
      current_filenode = Filenode.new(line.sub('$ cd ',''), 'dir', current_filenode)
    elsif line.index('cd ..')
      current_filenode = current_filenode.parent
    elsif line.index('cd ')
      dir_name = line.sub('$ cd ','')
      current_filenode = current_filenode.children[dir_name]
    elsif line.index('dir')
      dir_name = line.sub('dir ','')
      filenode = Filenode.new(dir_name, 'dir', current_filenode)
      current_filenode.add_child(filenode)
    elsif line.count('0-9').positive?
      terminal_node = line.split(' ')
      filenode = Filenode.new(terminal_node[1], 'file', current_filenode)
      filenode.memory_footprint(terminal_node[0].to_i)
      current_filenode.add_child(filenode)
    end
  end
  while current_filenode.parent do 
    current_filenode = current_filenode.parent 
  end
  current_filenode
end

def tree(lines)
  @tree ||= build_tree(lines)
end

def calculate_total_value(root)
  root.memory_footprint
  root.find_sum_small
end

def calculate_smallest_deletion(root)
  current_free_space = 70_000_000 - root.memory_footprint
  required = 30_000_000
  needed_space = required - current_free_space
  root.find_smallest_deletion(needed_space)
end

print "solution 1: #{calculate_total_value(tree(parse_file))}"
puts
print "solution 2: #{calculate_smallest_deletion(tree(parse_file))}"
puts
