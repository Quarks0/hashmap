class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    sum = 0
    self.each_with_index { |elem, i| sum += elem.hash*i.hash}
    return sum
  end
end

class String
  def hash
    alphabet = ('a'..'z').to_a
    return self.length.hash*self.split("").map{|el| alphabet.index(el)}.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hash_as_array = []
    self.each{|k,v| hash_as_array << [k,v]}
    hash_as_array.sort!
    hash_as_array.hash
  end
end
