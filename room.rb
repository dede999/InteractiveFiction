class Rooms
  attr_accessor :name, :north, :east, :west, :south, :flags, :stuff_there, @is_locked

  def initialize (name, n, s, e, w, locked = false)
    @name = name
    @flags = Hash.new{}
    @north = nil
    @south = nil
    @west = nil
    @east = nil
    @stuff_there = []
    @is_locked = locked
  end

  def lock

  end

  def unlock

  end
end