require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    @count += 1 unless include?(key)
    if @count > num_buckets
      temp = @store.dup
      resize!
      temp.each do |link|
        link.each do |node|
          bucket(node.key).append(node.key, node.val)
        end
      end
    end
    bucket(key).append(key, val)
  end

  def get(key)
  end

  def delete(key)
  end

  def each(&prc)
    @store.each do |bucket|
      bucket.each do |link|
        yield link
      end
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    @store = Array.new(num_buckets * 2) {[]}
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets]
  end
end
