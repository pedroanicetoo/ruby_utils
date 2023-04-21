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
    remove_or_update_steps(list, node, data)
  end

  def self.remove(list, node)
    remove_or_update_steps(list, node)
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
