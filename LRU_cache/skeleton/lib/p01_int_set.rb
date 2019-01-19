class MaxIntSet
  def initialize(max)
    @arr = Array.new(max) {false}
  end

  def insert(num)
    raise "Out of bounds" unless is_valid?(num)
    @arr[num] = true
  end

  def remove(num)
    @arr[num] = false
  end

  def include?(num)
    @arr[num] == true
  end

  private

  def is_valid?(num)
    num < @arr.length && num > 0
  end

  def validate!(num)

  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[num % num_buckets] << num unless include?(num)
  end

  def remove(num)
    @store[num % num_buckets].delete(num)
  end

  def include?(num)
    @store.each do |bucket|
      return true if bucket.include? num
    end
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    return if include?(num)
    @count += 1
    if @count > num_buckets
      temp = @store.dup
      resize!
      temp.each do |bucket|
        bucket.each do |el|
          @store[el % num_buckets] << el
        end
      end
    end
    @store[num % num_buckets] << num
  end

  def remove(num)
    if include?(num)
      @store[num % num_buckets].delete(num) 
      @count -= 1
    end
  end

  def include?(num)
    @store.each do |bucket|
      return true if bucket.include? num
    end
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    @store = Array.new(num_buckets * 2) {[]}
  end
end
