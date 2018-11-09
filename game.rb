class Element

end

class Rooms
  attr_accessor :name,
  def initialize (name)
    @name = name
    @flags = Hash.new{}
    @north = nil
    @south = nil
    @west = nil
    @east = nil
    @stuff_there = []
  end
end

class Things

end

class Games
  def initilize
    @turns = 0
    @inventory = []
    @historic = []
  end

  def turn

  end

end