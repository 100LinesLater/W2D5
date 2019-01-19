class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    return if include?(key)
    @count += 1
    if @count > num_buckets
      temp = @store.dup
      resize!
      temp.each do |bucket|
        bucket.each do |el|
          self[el] << el
        end
      end
    end
    self[key] << key      
  end

  def include?(key)
    self[key].include? key 
  end

  def remove(key)
    return unless include?(key)
    self[key].delete(key)
    @count -= 1
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    @store = Array.new(num_buckets * 2) {[]}
  end
end
