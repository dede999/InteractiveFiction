class Element
  attr_accessor :attr, :flags, :desc, :short
  attr_reader :nome

  def initialize(nome, attr = Hash.new{}, flags = Hash.new{}, desc = "", short = "")
    @name = nome
    @attr = attr
    @flags = flags
    @desc = desc
    @short = short
  end

  def change_variables (var, new_var)
    self.attr[var] = new_var
  end

  def modify flag
    if self.flags.has_key?(flag)
      self.flags[flag] = !self.flags[flag]
    else
      self.flags[flag] = true
    end 
  end
end

class Games < Element
  attr_accessor :events, :turns, :success, :begun,
                :historic, :characters
  attr_reader :intro, :authors, :version
  @@characters = []

  def initialize(nome, intro, authors="", version)
    @name = nome
    @intro = intro
    @authors = authors.split(",")
    @version = version
    @turns = 0
    @events = []
    @success = false
    @begun = false
    @historic = []
    @meta = Hash.new{}
  end

  def characters
    @@characters
  end

  def self.characters
    @@characters
  end

  def start
    var = false
    for ch in Games.characters do
      var = ch.protagonist
      if var
        break
      end
    end
    unless var
      return var
    end
    self.begun = true
    self.success = false
    self.historic = []
    self.turns = 0
  end

  def new_turn
    self.turns += 1
    poped = self.pop_task()
  end

  def schedule_tasks
    vec = self.events.sort {|a, b| 
      a.moment <=> b.moment}
    self.events = vec
  end

  def pop_task
    if self.events[0].moment == self.turns
      poped = self.events.shift()
    end
    poped ? true : false
  end

  def end_game(win=true)
    self.begun = false
    self.success = win
  end

  def has_a_main
    Games.characters == [] ? false : true
  end

end

class Rooms < Element
  attr_accessor :name, :north, :east, :west, :south,
                :flags, :stuff_there, :is_locked

  def initialize (name)
    @name = name
    @desc = ""
    @flags = Hash.new{}
    @north = nil
    @south = nil
    @west = nil
    @east = nil
    @stuff_there = []
    @is_locked = false
  end

  def lock var
    if self.is_locked ^ var
      self.is_locked = var
      return true
    else
      return false
    end
  end

  def look_around
    look = ""
    for stuff in self.stuff_there()
      look << "#{stuff.name} "
    end
  end
end

class Thing < Element
  attr_accessor :where, :desc, :short, :attr, :flags,
                :quantity, :endure, :active
  attr_reader :name

  def initialize(nome)
    @name = nome
    @where = nil
    @desc = ""
    @short = ""
    @attr = Hash.new{}
    @flags = Hash.new{}
    @quantity = 1
    @endure = 10 # number of turns 'til it breaks
    @active = true
  end

  def move_stuff(to = self.where)
    if to.is_locked or to == self.where
      return false
    else
      self.where.stuff_there -= [self]
      self.where = to
      self.where.stuff_there += [self]
      return true
    end
  end

  def activate yes
    if self.active ^ yes
      if self.endure <= 0
        return false
      else
        self.active = yes
        return false
      end
    else
      return false
    end
  end

  def use
    if self.active
      self.endure -= 1
      if self.endure <= 0
        self.active = false
      end
      return true
    else
      return false
    end
  end

  def repair rr
    self.endure += rr
  end

end

class Character < Element
  attr_accessor :desc, :short_desc, :attr, :where,
                :inventory, :protagonist, :hp, :sp,
                :coins
  attr_reader :name

  def initializer(name, where)
    @name = name
    @desc = ""
    @short_desc = ""
    @attr = Hash.new{}
    @where = where
    @inventory = []
    @protagonist = false
    @hp = 100
    @sp = 0
    @coins = 0
    Games.characters << self
  end

  # def is_there_any_main
  # end

  def life_up_and_down(value, heal=true)

  end

  def strength_up_and_down(value, heat_up=true)

  end

  def money_up_and_down(value, income=true)

  end

  def attack(target)

  end

  def object_in_and_out(thing, get = 1)

  end
end

class Event < Element
  attr_accessor :moment, :local, :proc, :cond,
                :done, :desc, :par, :lamb, :locked
  attr_reader :name

  def initialize (name="", desc="")
    @name = name
    @desc = desc
    @par = 0
    @local = Hash.new{} # local variables
    @locked = false
    @moment = -1
    @cond = ""
    @done = false
    @lamb = ""
    @proc = nil
  end

  def create_procedure
    0
  end

  def make_it_happen (*args)
    # execute procedure
  end

  def activate_trigger
    # test trigger condition
  end
end
