require_relative 'linked_list'

class Node
  attr_accessor :data, :next

  def initialize(data)
    @data = data
    @next = nil
  end
end

class PersistentList
  def self.empty
    list = LinkedList.new
    list.freeze
  end

  def self.insert(list, data)
    ret = self.copy list
    ret.insert data
    ret.freeze
  end

  def self.update(list, node, data)
    new_list = LinkedList.new
    found = false
    list.each do |nd|
      if found
        new_list = new_list.reuse_from_node(nd)
        break
      end
      if found = (node.data == nd.data)
        new_list.insert(data)
        next
      end
      new_list.insert(nd.data)
    end
    new_list
  end


  class << self
    private

    def copy src
      new_list = LinkedList.new
      new_list.each { |node| new_list.insert node.data }
      new_list
    end
  end

end
