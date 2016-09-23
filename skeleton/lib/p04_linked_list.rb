class Link
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
end

class LinkedList
  include Enumerable

  def initialize
    @head = Link.new
    @tail = Link.new

    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    current_link = first

    until current_link == @tail
      return current_link.val if current_link.key == key
      current_link = current_link.next
    end

    nil
  end

  def get_link(key)
    current_link = first

    until current_link == @tail
      return current_link if current_link.key == key
      current_link = current_link.next
    end

    nil
  end

  def include?(key)
    current_link = first

    while current_link != @tail
      return true if current_link.key == key
      current_link = current_link.next
    end

    false
  end

  def insert(key, val)
    new_link = Link.new(key, val)

    current_link = first

    until current_link == @tail
      unless new_link.val < current_link.val
        current_link = current_link.next
      end
    end

    new_prev = current_link.prev
    current_link.prev = new_link
    new_prev.next = new_link

    new_link.prev = new_prev
    new_link.next = current_link
  end

  def remove(key)
    delete_link = get_link(key)

    delete_link.prev.next = delete_link.next
    delete_link.next.prev = delete_link.prev
  end

  def each(&prc)
    current_link = first

    until current_link == @tail
      prc.call(current_link)
      current_link = current_link.next
    end

  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
