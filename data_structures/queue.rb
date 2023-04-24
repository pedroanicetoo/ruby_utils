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
    arr
  end
end

=begin
  USAGE EXAMPLES

  q = Queue.new
  .queue(data) => (Queue)
  n1 = q.queue 1
  -> [1]
  n2 = q.queue 2
  -> [1, 2]
  n3 = q.queue 3
  -> [1, 2, 3]

  .dequeue => (Queue)
  q.dequeue
  -> [2, 3]
  q.dequeue
  -> [3]

  .peek => (node)
  q.peek
  -> [3]

  .clear => (Queue)
  q.clear
  -> #<Thread::Queue:0x00007f9c5c3c1ea0 @head=nil, @length=0, @tail=nil>

  .each &predicate => (nil || block return)
  q = Queue.new
  q.enqueue 1
  q.enqueue 3
  q.each { |x| (x.data == 3) ? puts('yes') : puts('no') }
  -> no
  -> yes
  -> nil

  .print => (Array)
  q.print
  -> [1, 3]

=end
