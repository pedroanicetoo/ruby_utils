
require_relative 'linked_list'

class Node
  attr_accessor :data, :prev, :next

  def initialize(data)
    @data = data
    @prev = nil
    @next = nil
  end
end

class DubleLinkedList < LinkedList
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
      node.prev = @tail
      @tail.next = node
    end
    @tail = node
    @length += 1
    node
  end

  def remove(node)
    return if node.nil?
    return if @length == 0

    if node == head
      if @head.next.nil?
        @head = @tail = nil
      else
        @head = @head.next
      end
    else
      p, n = node.prev, node.next
      p&.next = n
      n&.prev = p
    end
    @length -= 1
    self
  end

  def cat(list)
    return unless list.is_a?(DubleLinkedList)
    return list if @length == 0

    list.head.prev = @tail
    @tail.next = list.head
    @tail = list.tail
    @length += list.length
  end

  def find_last &predicate
    return nil unless block_given?

    current = @tail
    while current
      return current if predicate.call(current.data)

      current = current.prev
    end
  end

  def reverse_each
    return nil unless block_given?

    current = @tail
    while current
      yield current
      current = current.prev
    end
  end

  def reverse_print
    return 'empty' if @length == 0

    arr = []
    reverse_each { |item| arr << item.data }
    arr
  end
end

=begin
  USAGE EXAMPLES

  dl = DubleLinkedList.new
  .insert => (node)
  n1 = dl.insert 1
  -> [1]
  n2 = dl.insert 2
  -> [1, 2]
  n3 = dl.insert 3
  -> [1, 2, 3]

  .remove => (self)
  dl.remove n1 // head case
  -> [2, 3]
  dl.remove n2 // not head case
  -> [3]

  .cat => (self)
  dl1 = DubleLinkedList.new
  dl2 = DubleLinkedList.new
  dl1.insert 1
  -> [1]
  dl1.insert 2
  -> [1, 2]
  dl2.insert 3
  -> [3]
  dl1.cat dl2
  -> [1, 2, 3]

  .clear => (self)
  dl = DubleLinkedList.new
  dl.insert 1
  dl.insert 2
  dl.clear
  -> [] (its not the output, just a visual representation)

  .find_first &predicate => (node)
  dl = DubleLinkedList.new
  dl.insert({a:'bar', b:10})
  -> [{a:'foo', b:10}]
  dl.insert({a:'foo', b:10})
  -> [{a:'bar', b:10}, {a:'foo', b:10}]
  dl.insert({a:'foo', b:20})
  -> [{a:'bar', b:10}, {a:'foo', b:10}, {a:'foo', b:20}]
  dl.find_first { |item| item[:a] == 'foo' }
  -> {a:'foo', b: 10}

  .find_last &predicate => (node)
  dl = DubleLinkedList.new
  dl.insert({a:'bar', b:10})
  -> [{a:'foo', b:10}]
  dl.insert({a:'bar', b:20})
  -> [{a:'bar', b:10}, {a:'bar', b:20}]
  dl.insert({a:'foo', b:20})
  -> [{a:'bar', b:10}, {a:'foo', b:10}, {a:'foo', b:20}]
  dl.find_last { |item| item[:a] == 'bar' }
  -> {a:'bar', b: 20}

  .each &predicate => (nil || block return)
  dl = DubleLinkedList.new
  dl.insert true
  dl.insert false
  dl.insert true

  dl.each { |x| (x.data == true) ? puts('yes') : puts('no') }
  -> yes
  -> no
  -> yes

  .print => (Array)

  dl.print
  -> [true, false, true]

  .reverse_each &predicate => (nil || block return)
  dl = DubleLinkedList.new
  dl.insert true
  dl.insert true
  dl.insert false

  dl.reverse_each { |x| (x.data == true) ? puts('yes') : puts('no') }
  -> no
  -> yes
  -> yes

  .reverse_print => (Array)

  dl.reverse_print
  -> [false, true, true]

=end
