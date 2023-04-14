require 'benchmark'
require_relative '../data_structures/singly_linked.rb'
require_relative '../data_structures/double_linked.rb'

module Benchmarks
  include Benchmark
  module LinkedList
    SINGLY_LINKED = SinglyLinked.new
    DOUBLE_LINKED = DoubleLinked.new
    EXAMPLES = 1000
    def self.insert
      Benchmark.bm(7) do |x|
        x.report("singly_linked:") do
          EXAMPLES.times { |data| SINGLY_LINKED.insert data }
        end
        x.report("double_linked:") do
          EXAMPLES.times { |data| DOUBLE_LINKED.insert data }
        end
      end
    end
  end
end
