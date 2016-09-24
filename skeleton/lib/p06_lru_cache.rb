require_relative 'p05_hash_map'
require_relative 'p04_linked_list'
require 'byebug'

class LRUCache
  attr_reader :map
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc ||= Proc.new{|x| x**2}
  end

  def count
    @map.count
  end
#fixed some syntax errors, but we'll have to double check what happens when we add the same key 3 times
  def get(key)
    if key == 0
      debugger
    end
    if @map.include?(key)
      update_link!(@map.get_link(key))
    else
      if count == @max
        #debugger
        eject!
      end
      calc!(key)
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    val = @prc.call(key)
    new_link = Link.new(key,val)
    update_link!(new_link)
    @map.set(key,val)
    return new_link.val
  end

  def update_link!(link)
    # suggested helper method; move a link to the end of the list
    # debugger
    if count == 0
      link.prev = @store.last
      link.next = @store.first
      link.prev.next = link
      link.next.prev = link
    else
      if !link.prev.nil?
        link.prev.next = link.next
        link.next.prev = link.prev
      end

      link.prev = @store.last.prev
      link.next = @store.last
      link.prev.next = link
      @store.last.prev = link
    end

    link.val
  end

  def eject!
    @map.delete(@store.first.key)
    @store.first.next = @store.first.next.next
    @store.first.next.prev = @store.first
  end
end
