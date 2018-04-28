class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    sum = 0
    self.each_with_index {|el, idx| sum += (el.hash * idx) }
    sum
  end
end

class String
  def hash
    sum = 0
    self.chars.each_with_index { |char, idx| sum += (char.ord * idx).hash }
    sum
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    temp = []
    self.each do |key, value|
      temp << [key, value]
    end

    temp.sort.hash
  end
end
