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
    node.next = @head
    @head = node
    @length += 1
    self
  end

  def pop
    return if @length == 0

    @head = @head.next
    @tail = nil if @length == 1
    @length -= 1
    self
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

=begin
  USAGE EXAMPLES

  s = Stack.new

  .push(data) => (Stack)
  s.push(1)
  --
  1 (node)
  --
  .pop(data) => (Stack)
  --
  --

  .peek => (node)
  s.push 1
  s.push 2
  --
  2 (node)
  1 (node)
  --
  s.peek
  -> #<Node:0x00007fdf15eaa870 @data=2, @next=#<Node:0x00007fdf16319ca8 @data=1, @next=nil>>

  .clear => nil
  s.push 1
  s.push 2
  --
  2
  1
  --
  s.clear
  --
  --

  .each => nil
  s.push 1
  s.push 2
  --
  2
  1
  --
  s.each { |node| puts "match!" if node.data == 2 }
  -> match!
  -> nil

  .print => (string || nil) // yes, its nil, but on my humble opinion the sequencial puts command is better to represents a stack
  s.push 1
  s.push 2
  --
  2
  1
  --
  s.print
  -> 2
  -> 1
  -> nil

=end
