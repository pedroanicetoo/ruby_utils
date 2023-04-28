require_relative 'linked_list'

# monkey patched: add one method to use
class LinkedList
  def reuse_from_node(node)
    return self if node.nil?

    while node
      insert node.data
      node = node.next
    end
    self
  end
end


class PersistentList

  def self.insert(list, data)
    readonly = self.copy list
    readonly.insert data
    readonly.freeze
  end

  def self.update(list, node, data)
    remove_or_update_steps(list, node, data)
  end

  def self.remove(list, node)
    remove_or_update_steps(list, node)
  end

  def self.empty
    list = LinkedList.new
    list.freeze
  end

  def self.cat(lhs, rhs)
    readonly = copy lhs
    readonly.cat rhs
    readonly.freeze
  end

  def self.len list
    list&.length || 0
  end

  def self.find_first list &predicate
    return unless list

    list.find_first &predicate
  end

  def self.each list, &block
    return unless list

    list.each &block
  end

  def self.print list
    return 'empty' unless list

    list.print
  end

  class << self
    private

    def copy src
      new_list = LinkedList.new
      new_list.each { |node| new_list.insert node.data }
      new_list
    end

    def remove_or_update_steps(list, node, data = nil)
      new_list =  LinkedList.new
      found = false
      list.each do |nd|
        if found
          new_list = new_list.reuse_from_node(nd)
          break
        end
        if found = (nd.data == node.data)
          new_list.insert(data) if data
          next
        end
        new_list.insert(nd.data)
      end
      new_list.freeze
    end
  end

end


=begin
  USAGE EXAMPLES
  pl = PersistentList
  ll = LinkedList.new

  #insert(list, data) => (readonly LinkedList)
  pl.insert(ll, 1)
  pl.insert(ll, 2)
  pl.insert(ll, 3)
  -> [1, 2, 3] (LinkedList data values)

  #update(list, node, data) => (readonly LinkedList)
  old_node = ll.head.next (# 2)
  pl.update(ll, old_node, 5)
  -> [1, 5, 3] (LinkedList data values)

  #remove(list, node) => (readonly LinkedList)
  node = ll.head (# 1)
  pl.remove(ll, node)
  -> [2, 3] (LinkedList data values)

  #empty => (readonly LinkedList)
  pl.empty
  -> #<LinkedList:0x00007f332f3b3058 @head=nil, @length=0, @tail=nil>

  #cat(left_list, right_list) => (readonly LinkedList)
  ll = LinkedList.new
  ll.insert 1
  rl = LinkedList.new
  rl.insert 2
  pl.cat(ll, rl)
  -> [1, 2] (LinkedList data values)

  #len(list) => (Integer)
  ll = LinkedList.new
  pl.len(ll)
  -> 0

  #find_first(list) &predicate => (Node) | #each(list) &block => nil
  ll = LinkedList.new
  ll.insert 1
  ll.insert 2
  PersistentList.find_first(ll) { |data| data == 2 }
  -> #<Node:0x00007f332f2db298 @data=2, @next=nil>
  PersistentList.each(ll) {|node| puts 'match!' if  node.data == 2 }
  -> match!
  -> nil

  #print => (string || readonly LinkedList)
  ll = LinkedList.new
  ll.insert 1
  ll.insert 2
  PersistentList.print(ll)
  -> [1, 2] (LinkedList data values)

=end
