class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    val = 0
    self.map.with_index do |num, idx|
      val = val ^ num + (num % (idx + 1))
    end
    val.hash
  end
end

class String
  def hash
    # alpha = ("a".."z").to_a
    val = 0
    self.chars.map.with_index do |ch, idx|
      val = val ^ ch.ord + (ch.ord % (idx + 1))
    end
    val.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    0
  end
end
