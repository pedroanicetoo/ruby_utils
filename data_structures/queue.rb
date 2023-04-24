class Node
  attr_accessor :data, :next

  def initialize(data)
    @data = data
    @next = nil
  end
end

class Queue
  attr_accessor :head, :length, :tail

  def initialize
    @head   = nil
    @tail   = nil
    @length = 0
  end

  def enqueue data
    node = Node.new data
    unless head
        @head = node
    else
        @tail.next = node
    end
    @tail = node
    @length += 1
    self
  end

  def dequeue
    return unless @head

    @head = @head.next
    @tail = nil if @length == 1
    @length -= 1
    self
  end

  def peek
    @head
  end

  def clear
    until peek.nil?
      dequeue
    end
    self
  end

  def each
    return unless block_given?

    current = @head
    while current
      yield current
      current = current.next
    end
  end

  def print
    return 'empty' unless @head

    arr = []
    current = @head
    each { |node| arr << node.data }
    p arr
  end
end
