require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    if include?(key)
      # bucket = get(key)
      bucket(key).update(key, val)
    else
      @store = resize! if @count == num_buckets
      bucket(key).append(key, val)
      @count += 1
    end
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    if include?(key)
      deleted = bucket(key).remove(key)
      @count -= 1
      return deleted 
    end
  end

  def each(&prc)
    @store.each do |linked_list|
      linked_list.each do |node|
        prc.call(node.key, node.val)
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
    bucket_count = num_buckets * 2
    new_array = Array.new(bucket_count) {LinkedList.new}

    self.each do |node_key, node_value|
      new_array[node_key.hash % bucket_count].append(node_key, node_value)
    end

    new_array
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    index = key.hash % num_buckets
    @store[index]
  end


end
