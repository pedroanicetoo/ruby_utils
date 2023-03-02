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
    return unless data

    node = Node.new data
    unless head
      self.head = node
    else
      self.tail.next = node
    end
    self.tail = node
    self.length += 1
    node
  end

  def remove(node)
    return unless node

    if node == head
      if head.next.nil?
          self.head = self.tail = nil
      else
          self.head = self.head.next
      end
    else
      return unless find(node)
      tmp = self.head
      while tmp && tmp.next != node
        tmp = tmp.next
      end
      tmp.next = node.next if tmp
    end
    self.length -= 1
  end


  def find(node)
    return unless node
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
    self.print
  end

  def print
    ar = []
    tmp = head
    until tmp.nil?
      ar << tmp.data
      tmp = tmp.next
    end
    p ar
  end
end


=begin
  sl = SinglyLinked.new

  # insert

  n1 = sl.insert 1
  n2 = sl.insert 2
  n3 = sl.insert 3

  # remove

  sl.remove n1 // head case
  sl.remove n2 // not head case

  # cat

  sl1 = SinglyLinked.new
  sl2 = SinglyLinked.new
  sl1.insert 1
  sl1.insert 2
  sl2.insert 3

  sl1.cat sl2

=end
