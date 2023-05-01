require_relative 'linked_list'

class Vertex
  attr_accessor :key, :edges, :next

  def initialize(key)
    @key = key
    @edges = []
    @next = nil
  end
end

#(LinkedList monkey-patched)
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

  def remove_next(prev_vertex)
    return unless @length > 0

    unless prev_vertex
      @head = @head.next # default remove
    else
      old = prev_vertex.next
      prev_vertex.next = prev_vertex.next&.next
      if old == @head
        @head = old.next
      end
    end

    @length -= 1
    self
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

  # remove only solitary vertices
  def remove_vertex key
    found  = false
    target = nil
    prev   = nil
    @vertices.each do |v|
      return if v.edges.include?(key)

      if v.key == key
        found  = true
        target = v
        break
      else
        prev = v
      end
    end

    return if !found || (target.edges.size != 0)

    @vertices.remove_next(prev)
  end

  def remove_edge(key1, key2)
    vertex = find_vertex(key1)&.key

    return unless vertex

    vertex.edges - [key2]
  end

  def adjacent?(key1, key2)
    vertex = find_vertex(key1)
    return true if vertex&.edges.include? key2

    false
  end

  def find_vertex key
    @vertices.find_first { |v| v == key }
  end

  def print
    @vertices.each do |v|
      puts "#{v.key} (vertex)"
      v.edges.each do |e|
        puts "    #{e} (edge)"
      end
    end
  end
end

=begin
  USAGE EXAMPLES

  g = Graph.new
  g.insert_vertex 1
  g.insert_vertex 2
  g.insert_vertex 3
  g.insert_vertex 4
  -> vertices : [key: 1, edges: []], [key: 2, edges: []], [key: 3, edges: []], [key: 4, edges: []]

  g.insert_edge(1, 2)
  g.insert_edge(2, 1)
  g.insert_edge(3, 1)
  -> vertices : [key: 1, edges: [2]], [key: 2, edges: [1]], [key: 3, edges: [1]], [key: 4, edges: []]
  g.remove_vertex(2)
  -> vertices : [key: 1, edges: [2]], [key: 2, edges: [1]], [key: 3, edges: [1]], [key: 4, edges: []] # does not remove because have edge
  g.remove_vertex(4)
  -> vertices : [key: 1, edges: [2]], [key: 2, edges: [1]], [key: 3, edges: [1]]]
  g.adjacent?(1, 3)
  -> false
  g.adjacent?(3, 1)
  -> true
  g.find_vertex(3)
  -> #<Vertex:0x00007fe799852478 @edges=[1], @key=3, @next=nil>
  g.print

  1 (vertex)
    2 (edge)
  2 (vertex)
    1 (edge)
  3 (vertex)
    1 (edge)

=end
