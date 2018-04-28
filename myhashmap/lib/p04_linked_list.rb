class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    @prev.next = @next
    @next.prev = @prev
    self
  end

end

class LinkedList
  include Enumerable
  def initialize
    @head = Node.new
    @tail = Node.new

    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    return nil if empty?
    current = @head.next
    i.times {current = current.next}
    current
    # each_with_index { |link, j| return link if i == j }
    # nil
  end

  def first
    @head.next unless empty?
  end

  def last
    @tail.prev unless empty?
  end

  def empty?
    @head.next == @tail && @tail.prev == @head
  end

  def get(key) #returns value attached to key
    self.each do |node|
      return node.val if node.key == key
    end

    nil
  end

  def include?(key)
    self.each do |node|
      return true if node.key == key
    end
    false
  end

  def append(key, val)
    n = Node.new(key,val)
    n.prev = @tail.prev
    @tail.prev.next = n
    @tail.prev = n
    n.next = @tail
  end

  def update(key, val)
    self.each do |node|
      node.val = val if node.key == key
    end
  end

  def remove(key)
    self.each do |node|
      return node.remove if node.key == key
    end
  end

  def each(&prc)
    return nil if empty?
    current = @head.next
    until current == @tail
      prc.call(current)
      current = current.next
    end

  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
