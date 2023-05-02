class Node
  attr_accessor :parent, :data, :left, :right

  def initialize(parent, data)
    @data = data
    @parent = parent
    @left = nil
    @ight = nil
  end
end

class Btree
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



  private

  def insert(type, node, data)
    @size += 1
    node.instance_variable_set("@#{type.to_s}", Node.new(node, data))
  end

end

=begin
  USAGE EXAMPLES

  root = Node.new(nil, 5)
  b = Btree.new(root)

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

=end
