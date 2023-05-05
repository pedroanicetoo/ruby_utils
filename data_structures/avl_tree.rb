class Node
  attr_accessor :key, :data, :deleted, :height, :left, :right

  def initialize(key, data)
    @key = key
    @data = data
    @deleted = false
    @height = 0
    @left = nil
    @right = nil
  end
end

class AvlTree

  attr_accessor :root

  def initialize; end

  def insert(key, data = nil)
    @root = insert_and_balance(@root, key, data)
  end

  def print
    print_rec @root, 0
  end

  private

  def insert_and_balance(node, key, data = nil)
    return Node.new(key, data) unless node

    if(key < node.key)
      node.left = insert_and_balance(node.left, key, data)
    elsif(key > node.key)
      node.right = insert_and_balance(node.right, key, data)
    else
      node.data    = data
      node.deleted = false
    end
    balance(node)
  end

  def balance(node)
    set_height(node)
    if(height(node.left) - height(node.right) == 2)
      if (height(node.left.right) > height(node.left.left))
        return rotate_left_right(node)
      end
      return rotate_right(node)
    elsif(height(node.right) - height(node.left) == 2)
      if (height(node.right.left) > height(node.right.right))
        rotate_right_left(node)
      end
      return rotate_left(node)
    end
    return node
  end

  def height node
    return 0 unless node

    node.height
  end

  def set_height(node)
    lh  = height node&.left
    rh  = height node&.right
    max = lh > rh ? lh : rh

    node.height = 1 + max
  end

  def rotate_right p
    q       = p.left
    p.left  = q.right
    q.right = p
    set_height p
    set_height q
    q
  end

  def rotate_left p
    q       = p.right
    p.right = q.left
    q.left  = p
    set_height p
    set_height q
    q
  end

  def rotate_left_right node
    node.left = rotate_left(node.left)
    rotate_right(node)
  end

  def rotate_right_left node
    node.right = rotate_right(node.right)
    rotate_left(node)
  end

  def print_rec node, indent
    unless node
      puts "x".rjust(indent * 4, " ")
      return
    end
    puts_key node, indent
    print_rec node.left, indent + 1
    print_rec node.right, indent + 1
  end

  def puts_key(node, indent)
    txt = node.key.to_s
    if node.deleted
      txt += " (D)"
      puts txt.rjust(indent * 8, " ")
    else
      puts txt.rjust(indent * 4, " ")
    end
  end

end