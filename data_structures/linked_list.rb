class Node
  attr_accessor :data, :next

  def initialize(data)
    @data = data
    @next = nil
  end
end

class LinkedList
  attr_accessor :head, :tail, :length

  def initialize
    @head = nil
    @tail = nil
    @length = 0
  end

  def insert(data)
    return if data.nil?

    node = Node.new data
    unless head
      @head = node
    else
      @tail.next = node
    end
    @tail = node
    @length += 1
    node
  end

  def remove(node)
    return if node.nil?

    if node == head
      if head.next.nil?
          @head = @tail = nil
      else
          @head = @head.next
      end
    else
      return if find(node).nil?
      tmp = @head
      while tmp && tmp.next != node
        tmp = tmp.next
      end
      tmp.next = node.next if tmp
    end
    @length -= 1
  end


  def find(node)
    return if node.nil?
    return head if node == head

    tmp = @head
    while tmp
      tmp = tmp.next
      if tmp == node
        return node
      end
    end
  end

  def cat(list)
    return unless list.is_a?(LinkedList)
    return list if @head.length == 0

    @tail.next = list.head
    @tail = list.tail
    @length += list.length
    self
  end

  def clear
    while @length > 0
      remove(@head)
    end
    self
  end

  def find_first &predicate
    return nil unless block_given?

    current = @head
    while current
      return current if predicate.call(current.data)

      current = current.next
    end
    current
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
    return 'empty' if @length == 0

    ar = []
    each { |item| ar << item.data }
    ar
  end
end

=begin
  USAGE EXAMPLES

  sl = LinkedList.new
  .insert(data) => (node)
  n1 = sl.insert 1
  -> [1]
  n2 = sl.insert 2
  -> [1, 2]
  n3 = sl.insert 3
  -> [1, 2, 3]

  .remove(node) => (integer)
  sl.remove n1 // head case
  -> [2, 3]
  sl.remove n2 // not head case
  -> [3]

  .cat(list) => (node)
  sl1 = LinkedList.new
  sl2 = LinkedList.new
  sl1.insert 1
  -> [1]
  sl1.insert 2
  -> [1, 2]
  sl2.insert 3
  -> [3]
  sl1.cat sl2
  -> [1, 2, 3]

  .clear => (self)
  sl = LinkedList.new
  sl.insert 1
  sl.insert 2
  sl.clear
  -> [] (its not the output, just a visual representation)

  .find_first &predicate => (node)
  sl = LinkedList.new
  sl.insert({a:'bar', b:10})
  -> [{a:'foo', b:10}]
  sl.insert({a:'foo', b:10})
  -> [{a:'bar', b:10}, {a:'foo', b:10}]
  sl.insert({a:'foo', b:20})
  -> [{a:'bar', b:10}, {a:'foo', b:10}, {a:'foo', b:20}]
  sl.find_first { |item| item[:a] == 'foo' }
  -> {a:'foo', b: 10}

  .each &predicate => (nil || block return)
  sl = LinkedList.new
  sl.insert true
  sl.insert false
  sl.insert true

  sl.each { |x| (x.data == true) ? puts('yes') : puts('no') }
  -> yes
  -> no
  -> yes

  .print => (String)

  sl.print
  -> [true, false, true]
=end
