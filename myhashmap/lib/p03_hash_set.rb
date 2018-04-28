require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if @count == num_buckets
      @store = resize!
    end

    unless self.include?(key)
      self[key.hash] << key
      @count +=1
    end
  end

  def include?(key)
    self[key.hash].include?(key)
  end

  def remove(key)
    if self.include?(key)
      self[key.hash].delete(key)
      @count -= 1
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    bucket_count = num_buckets * 2
    new_array = Array.new(bucket_count){[]}
    @store.each do |bucket|
      bucket.each do |el|
        new_array[el.hash % bucket_count] << el
      end
    end
    new_array
  end


end
