require "byebug"

class MaxIntSet
  def initialize(max)
    @store = Array.new(max,false)
  end

  def insert(num)
      @store[num] = true if is_valid?(num)
  end

  def remove(num)
    @store[num] = false if is_valid?(num)
  end

  def include?(num)
    @store[num] if is_valid?(num)
  end

  private

  def is_valid?(num)
    raise Exception, "Out of bounds" if num > @store.size || num < 0
    true
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    #debugger
    self[num] << num unless include?(num)
  end

  def remove(num)
    self[num].delete(num) if include?(num)
  end

  def include?(num)
    self[num].each do |elem|
      return true if num == elem
    end
    false
  end

  private

  def [](num)
    @store[num%num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if count >= num_buckets
    self[num] << num unless include?(num)
    @count +=1
  end

  def remove(num)
    self[num].delete(num) if include?(num)
    @count -=1
  end

  def include?(num)
    self[num].each do |elem|
      return true if num == elem
    end
    false
  end

  private

  def [](num)
    @store[num%num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
   newResizingIntSet = ResizingIntSet.new(num_buckets*2)
    @store.each do |bucket|
      bucket.each do |el|
        newResizingIntSet.insert(el)
      end
    end
    @store = newResizingIntSet.store
  end
end
