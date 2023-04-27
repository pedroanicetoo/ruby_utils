require_relative 'linked_list'

class Vertex
  attr_accessor :key, :edges, :next

  def initialize(key)
    @key = key
    @edges = []
    @next = nil
  end
end

# monkey patch on linked_list

class LinkedList
  def insert(vertex)
    return if vertex.key.nil?

    unless head
      @head = vertex
    else
      @tail.next = vertex
    end
    @tail = vertex
    @length += 1
    vertex
  end

  def find_first &predicate
    return nil unless block_given?

    current = @head
    while current
      return current if predicate.call(current.key)

      current = current.next
    end
    current
  end
end

class Graph
  attr_accessor :vertices

  def initialize
    @vertices = LinkedList.new
  end

  def insert_vertex key
    return if find_vertex key

    vertex = Vertex.new key
    @vertices.insert vertex
  end

  def insert_edge(key1, key2)
    # The graph must contains vertices.
    v1 = find_vertex key1
    return unless v1

    v2 = find_vertex key2
    return unless v2

    v1.edges << v2.key
  end

  def remove_vertex(key)
    # TODO
  end

  def remove_edge(key1, key2)
    # TODO
  end

  def adjacent?(key1, key2)
    # TODO
  end

  def find_vertex key
    @vertices.find_first { |v| v == key }
  end

  def print
    # TODO
  end

end
