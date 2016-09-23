require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_reader :count,:store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    resize! if @count >= num_buckets
    bucket(key).insert(key,val)
    @count +=1
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    bucket(key).remove(key)
    @count -=1
  end

  def each(&prc)
    @store.each do |bucket|
      bucket.each(&prc)
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    newHashMap = HashMap.new(num_buckets*2)
     @store.each do |list|
       list.each do |k, v|
         newHashMap.set(k, v)
       end
     end
     @store = newHashMap.store
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    return @store[key.hash%num_buckets]
  end

  def num_buckets
    return @store.length
  end
end
