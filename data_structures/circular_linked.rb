class Node
  attr_accessor :data, :prev, :next

  def initialize(data)
    @data = data
    @next = nil
  end
end

class CircularLinked
  attr_accessor :head, :length
  attr_writer :current

  def initialize
    @head = nil
    @current = nil
    @length = 0
  end

  def insert(data)
    return if data.nil?
    return insert_next(nil, data) if @length == 0
    return insert_next(@head, data) if @length == 1

    # finds the last node
    @current = @head
    i = 0
    while (i += 1) < @length
      move_next
    end

    insert_next(@current, data)
  end

  def insert_next(prev_node, data)
    new_node = Node.new data
    if prev_node.nil?
      @head = new_node.next = new_node
    else
      new_node.next = prev_node.next
      prev_node.next = new_node
    end
    @length += 1
  end

  def remove(node)
    return unless node
    return unless @length > 0

    # head?
    return remove_next(node) if @length == 1

    # Find the precedent node to the node we
    # want to remove.
    prev = @head
    while prev.next != node
      prev = prev.next
    end
    remove_next(prev)
  end

  def remove_next(prev_node)
    return unless @length > 0

    unless prev_node
      @head = @head.next # default remove
    else
      if prev_node.next == prev_node # prev_node is head
        @head = nil
      else
        old = prev_node.next
        prev_node.next = prev_node.next&.next
        if old == @head
          @head = old.next
        end
      end
    end

    @length -= 1
  end

  private

  def move_next
    @current = @current&.next
  end

end


=begin
  USAGE EXAMPLES

  cl = CircularLinked.new
  #insert
  n1 = cl.insert 1
  -> [1]
  n2 = cl.insert 2
  -> [1, 2]
  n3 = cl.insert 3
  -> [1, 2, 3]

=end
