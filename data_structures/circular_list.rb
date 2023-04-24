class Node
  attr_accessor :data, :prev, :next

  def initialize(data)
    @data = data
    @next = nil
  end
end

class CircularList
  attr_accessor :head, :length, :current

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
    new_node
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
    self
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
    self
  end

  def clear
    while @length > 0
      remove @head
    end
    self
  end

  def move_next
    return 'empty list!' if @current.nil?

    @current = @current&.next
    @current
  end

  def full_scan
    return nil unless block_given?
    @current = @head

    loop do
      yield self.current
      break if (move_next == @head)
    end
  end

  def find_first &predicate
    return nil unless block_given?

    @current = @head

    loop do
      return @current if predicate.call(@current.data)

      break if (move_next == @head)
    end
  end

  def print
    return "empty list!" if @length == 0

    arr = []
    full_scan { |item| arr << item.data }
    arr
  end

end


=begin
  USAGE EXAMPLES

  cl = CircularList.new
  .insert => (node)
  n1 = cl.insert 1
  ... -> [1] -> [1] ...
  n2 = cl.insert 2
  ... -> [1] -> [2] -> [1] -> [2] ...
  n3 = cl.insert 3
  ... -> [1] -> [2] -> [3] -> [1] -> [2] -> [3] ...

  .insert_next => (self)
  cl.insert_next(n2, 4)
  ... -> [1] -> [2] -> [4] -> [3] -> [1] -> [2] -> [4] -> [3] ...

  .remove => (self)
  cl.remove n1 // head case
  ... -> [1] -> [2] -> [1] -> [2] ...
  cl.remove n2 // not head case
  ... -> [3] -> [3] ...

  .remove_next => (integer)
  (with a list: ... -> [1] -> [2] -> [3] -> [1] -> [2] -> [3] ...)
  cl.remove_next(n1) // removing [2] node
  ... -> [1] -> [3] -> [1] -> [3] ...

  .clear => (self)
  cl.insert 1
  cl.insert 2
  cl.clear
  -> [] (its not the output, just a visual representation)

  .move_next => (node)
  n1 = cl.insert 1
  n2 = cl.insert 2
  cl.current = n1 // set current
  cl.move_next
  -> [2] (n2)

  .full_scan => (block return || nil)
  (with a list: ... -> [1] -> [2] -> [3] -> [1] -> [2] -> [3] ...)
  cl.full_scan { |x| p x.data if x.data <= 2}
  -> 1
  -> 2
  -> nil

  .find_first &predicate => (node || nil)
  (with a list: ... -> [1] -> [2] -> [3] -> [1] -> [2] -> [3] ...)
  cl.find_first { |node| p node if node.data == 2}
  -> [2] // #<Node:0x00007f1d0139f358 ...>>>>

  .print => (Array)
  cl = CircularList.new
  n1 = cl.insert 1
  n2 = cl.insert 2
  n3 = cl.insert 3
  -> [1, 2, 3]

=end
