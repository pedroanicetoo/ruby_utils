class Node
  attr_accessor :data, :next

  def initialize(data)
    @data = data
    @next = nil
  end
end

# Stacks are a special kind of linked lists that allow us to efficiently store retrieve data in last in, first out order (LIFO).
class Stack
  attr_accessor :head, :tail, :length

  def initialize
    @head = nil
    @tail = nil
    @length = 0
  end

  def push(data)
    node = Node.new data
    if @length == 0
      @tail = node
    end
    node.next = self.head
    @head = node
    @length += 1
  end

  def pop
    return if @length == 0

    @head = @head.next
    @tail = nil if @length == 1
    @length -= 1
  end

  def peek
    @head
  end

  def clear
    while peek; pop; end
  end

  def each
    return nil unless block_given?

    current = @head
    while current
      yield current
      current = current.next
    end
  end

  def print
    return puts "empty" if @length == 0

    each { |node| puts node.data }
  end

end
