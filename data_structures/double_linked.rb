require_relative 'singly_linked'

class Node
  attr_accessor :data, :prev, :next

  def initialize(data)
    self.data = data
    self.prev = nil
    self.next = nil
  end
end

class DoubleLinked < SinglyLinked
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
      node.prev = self.tail
      self.tail.next = node
    end
    self.tail = node
    self.length += 1
  end

  #TODO: #remove
  #TODO: #cat
  #TODO: #find_last
  #TODO: #reverse_each
  #TODO: #reverse_print

end


=begin

Interface Complexity

#head                      O(1)
#tail                      O(1)
#length                    O(1)
#initialize                O(1)
#insert(item)              O(1)
#remove(item)              O(1)
#cat(list)                 O(1)
#clear                     O(n)
#find_first(&predicate)    O(n)
#each                      O(n)
#reverse_each              O(n)
#print                     O(n)
#reverse_print             O(n)
#find_last(&predicate)     O(n)

=end

=begin
  USAGE EXAMPLES

  dl = DoubleLinked.new
  #insert
  n1 = dl.insert 1
  -> [1]
  n2 = dl.insert 2
  -> [1, 2]
  n3 = dl.insert 3
  -> [1, 2, 3]

  #remove
  dl.remove n1 // head case
  -> [2, 3]
  dl.remove n2 // not head case
  -> [3]

  #cat
  dl1 = DoubleLinked.new
  dl2 = DoubleLinked.new
  dl1.insert 1
  -> [1]
  dl1.insert 2
  -> [1, 2]
  dl2.insert 3
  -> [3]
  dl1.cat dl2
  -> [1, 2, 3]

  #clear
  dl = DoubleLinked.new
  dl.insert 1
  dl.insert 2
  dl.clear
  -> [] (its not the output, just a visual representation)

  #find_first
  dl = DoubleLinked.new
  dl.insert({a:'bar', b:10})
  -> [{a:'foo', b:10}]
  dl.insert({a:'foo', b:10})
  -> [{a:'bar', b:10}, {a:'foo', b:10}]
  dl.insert({a:'foo', b:20})
  -> [{a:'bar', b:10}, {a:'foo', b:10}, {a:'foo', b:20}]
  dl.find_first { |item| item[:a] == 'foo' }
  -> {a:'foo', b: 10}

  #each
  dl = DoubleLinked.new
  dl.insert true
  dl.insert false
  dl.insert true

  dl.each { |x| (x.data == true) ? puts('yes') : puts('no') }
  -> yes
  -> no
  -> yes

  #print (use the example above)

  dl.print
  -> [true, false, true]
=end
