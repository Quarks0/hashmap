require_relative 'p02_hashing'

class HashSet
  attr_reader :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if count >= num_buckets
    self[key] << key unless include?(key)
    @count +=1
  end

  def include?(key)
    self[key].each do |elem|
      return true if key == elem
    end
    false
  end

  def remove(key)
    self[key].delete(key) if include?(key)
    @count -=1
  end

  private

  def [](key)
    key = key.hash
    # optional but useful; return the bucket corresponding to `key`
    @store[key % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    newResizingIntSet = HashSet.new(num_buckets*2)
     @store.each do |bucket|
       bucket.each do |el|
         newResizingIntSet.insert(el)
       end
     end
     @store = newResizingIntSet.store
  end

end
