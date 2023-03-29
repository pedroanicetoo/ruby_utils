class Node
  attr_accessor :data, :next

  def initialize(data)
    self.data = data
    self.next = nil
  end
end

class SinglyLinked
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
      self.head = node
    else
      self.tail.next = node
    end
    self.tail = node
    self.length += 1
  end

  def remove(node)
    return if node.nil?

    if node == head
      if head.next.nil?
          self.head = self.tail = nil
      else
          self.head = self.head.next
      end
    else
      return if find(node).nil?
      tmp = self.head
      while tmp && tmp.next != node
        tmp = tmp.next
      end
      tmp.next = node.next if tmp
    end
    self.length -= 1
  end


  def find(node)
    return if node.nil?
    return head if node == head

    tmp = self.head
    while tmp
      tmp = tmp.next
      if tmp == node
        return node
      end
    end
  end

  def cat(list)
    return unless list.is_a?(SinglyLinked)

    self.tail.next = list.head
    self.tail = list.tail
    self.length += list.length
  end

  def clear
    while self.length > 0
      remove(self.head)
    end
  end

  def find_first &predicate
    return nil unless block_given?

    current = self.head
    while current
      return current.data if predicate.call(current.data)

      current = current.next
    end
  end

  def each
    return unless block_given?

    current = self.head

    while current
      yield current
      current = current.next
    end
  end

  def print
    return 'empty' if self.length == 0

    ar = []
    each { |item| ar << item.data }
    p ar
  end
end


=begin
  USAGE EXAMPLES

  sl = SinglyLinked.new
  #insert
  n1 = sl.insert 1
  -> [1]
  n2 = sl.insert 2
  -> [1, 2]
  n3 = sl.insert 3
  -> [1, 2, 3]

  #remove
  sl.remove n1 // head case
  -> [2, 3]
  sl.remove n2 // not head case
  -> [3]

  #cat
  sl1 = SinglyLinked.new
  sl2 = SinglyLinked.new
  sl1.insert 1
  -> [1]
  sl1.insert 2
  -> [1, 2]
  sl2.insert 3
  -> [3]
  sl1.cat sl2
  -> [1, 2, 3]

  #clear
  sl = SinglyLinked.new
  sl.insert 1
  sl.insert 2
  sl.clear
  -> [] (its not the output, just a visual representation)

  #find_first
  sl = SinglyLinked.new
  sl.insert({a:'bar', b:10})
  -> [{a:'foo', b:10}]
  sl.insert({a:'foo', b:10})
  -> [{a:'bar', b:10}, {a:'foo', b:10}]
  sl.insert({a:'foo', b:20})
  -> [{a:'bar', b:10}, {a:'foo', b:10}, {a:'foo', b:20}]
  sl.find_first { |item| item[:a] == 'foo' }
  -> {a:'foo', b: 10}

  #each
  sl = SinglyLinked.new
  sl.insert true
  sl.insert false
  sl.insert true

  sl.each { |x| (x.data == true) ? puts('yes') : puts('no') }
  -> yes
  -> no
  -> yes

  #print (use the example above)

  sl.print
  -> [true, false, true]
=end
