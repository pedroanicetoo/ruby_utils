class Node
  attr_accessor :parent, :data, :left, :right

  def initialize(parent, data)
    @data = data
    @parent = parent
    @left = nil
    @ight = nil
  end
end


# WARNING: This binary tree is unbalanced and unordered

class BTree
  attr_accessor :root, :size

  def initialize(root)
    @root = root
    @size = 1
  end

  def insert_left(node, data)
    return unless node

    raise "Can't override nodes :(" if node.left
    insert(:left, node, data)
  end

  def insert_right(node, data)
    return unless node

    raise "Can't override nodes :(" if node.right
    insert(:right, node, data)
  end

  def remove_left(node)
    return unless node&.left

    remove_left(node.left)
    remove_right(node.left)
    node.left = nil
    @size -= 1
    self
  end

  def remove_right(node)
    return unless node&.right

    remove_left(node.right)
    remove_right(node.right)
    node.right = nil
    @size -= 1
    self
  end

  def self.merge(left_tree, right_tree, data = nil)
    raise "Can't merge nil trees." unless left_tree && right_tree

    root           = Node.new(nil, data);
    res            = BTree.new root
    res.root.left  = left_tree.root
    res.root.right = right_tree.root
    res.size       = left_tree.size + right_tree.size
    res
  end

  def print
    print_rec(@root)
  end

  private

  def insert(type, node, data)
    @size += 1
    node.instance_variable_set("@#{type.to_s}", Node.new(node, data))
  end

  def print_rec(node, indent = 0)
    data = node&.data || "nil"
    left_data = node&.left&.data|| "nil"
    right_data = node&.right&.data|| "nil"
    puts(data, "left_child=#{left_data}", "right_child=#{right_data}")

    print_rec(node.left, indent + 1) if node&.left
    print_rec(node.right, indent + 1) if node&.right
  end

end

=begin
  USAGE EXAMPLES

  root = Node.new(nil, 5)
  b = BTree.new(root)

  .insert_left => (self)
  n1 = b.insert_left(root, 4)
  n1_error = b.insert_left(root, 3) # raise an error

  .insert_right => (self)
  n2 = b.insert_right(root, 6)
  n1_error = b.insert_right(root, 7) # raise an error

  n1_2 = b.insert_left(n1, 3)
  n2_2 = b.insert_right(n2, 7)

      5
     / \
    4   6
   /     \
  3       7

  .remove_left => (self)
  b.remove_left(n1_2.parent) # removing 3

    5
   / \
  4   6
       \
        7

  .remove_right => (self)
  b.remove_right(n2_2.parent) # removing 7

    5
   / \
  4   6


  BTree.merge(left_tree, right_tree, data = nil) => (self)
  left_tree  right_tree
     2         6
    / \       / \
   1   3     5   7

  data = 5

          5
        /  \
      2      6
     / \    / \
    1   3  5   7

  .print => (string)

  root = Node.new(nil, 5)
  b = BTree.new(root)
  n1 = b.insert_left(root, 4)
  n2 = b.insert_right(root, 6)
  n1_2 = b.insert_left(n1, 3)
  n2_2 = b.insert_right(n2, 7)
  b.print

  =>
  5
  left_child=4
  right_child=6
  4
  left_child=3
  right_child=nil
  3
  left_child=nil
  right_child=nil
  6
  left_child=nil
  right_child=7
  7
  left_child=nil
  right_child=nil

=end
