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

  def remove key
    search(key)&.deleted = true
  end

  def search key
    node = search_rec @root, key

    return node unless node&.deleted
  end

  def print
    print_rec @root
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

  def search_rec(node, key)
    return nil unless node
    return search_rec(node.left, key)  if (key < node.key)
    return search_rec(node.right, key) if (key > node.key)
    node
  end

  def print_rec node
    return unless node

    puts "key: #{node&.key || '-'} | left: #{node.left&.key || '-'} | right: #{node.right&.key || '-'}"
    print_rec node.left
    print_rec node.right
  end

end
