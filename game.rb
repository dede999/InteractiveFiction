class Element
  attr_accessor :attr, :flags, :desc, :short
  attr_reader :nome

  def initialize(nome, **kwargs)
    @name = nome
    @atrb = Hash.new
    @flags = Hash.new
    @desc = kwargs[:desc] ? kwargs[:desc] : ""
    @short = kwargs[:short] ? kwargs[:short] : ""
  end

  def change_variables (var, new_var)
    self.atrb[var] = new_var
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

  def initialize(nome, **kw)
    @name = nome
    @intro = kw[:intro] ? kw[:intro] :  ""
    @authors = kw[:authors] ? kw[:authors].split(",") : ""
    @version = kw[:version] ? kw[:version] :  ""
    @turns = 0
    @events = []
    @success = false
    @begun = false
    @historic = []
    @meta = Hash.new{}
    @characters = []
  end

  # These methods are no longer needed
  #   but in case I have a similar trouble
  #   with class variables in Ruby, I can 
  #   check how I did it
  # def characters
  #   @@characters
  # end
  # def self.characters
  #   @@characters
  # end

  def authors=(var)
    @authors = var.split(",")
  end

  def start
    var = self.has_a_main()
    if var
      self.begun = true
      self.success = false
      self.historic = []
      self.turns = 0
    end
    return var
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
    for ch in self.characters do
      if ch.protagonist
        return true
      end
    end
    return false
  end

end

class Rooms < Element
  attr_accessor :name, :north, :east, :west, :south,
                :flags, :stuff_there, :is_locked

  def initialize (name, **kw)
    @name = name
    @desc = kw[:desc] ? kw[:desc] : ""
    @flags = Hash.new{}
    @north = kw[:n] ? kw[:n] : nil
    @south = kw[:s] ? kw[:s] : nil
    @west = kw[:w] ? kw[:w] : nil
    @east = kw[:e] ? kw[:e] : nil
    @stuff_there = kw[:stuff] ? kw[:stuff] : []
    @is_locked = kw[:lock] ? kw[:lock] : false
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
      piece = "#{stuff.name} "
      look << piece
    end
    look
  end
end

class Thing < Element
  attr_accessor :where, :desc, :short, :atrb, :flags,
                :quantity, :endure, :active
  attr_reader :name

  def initialize(nome, **kw)
    @name = nome
    @where = kw[:where] ? kw[:where] : nil
    @desc = kw[:desc] ? kw[:desc] : ""
    @short = kw[:short] ? kw[:short] : ""
    @atrb = Hash.new{}
    @flags = Hash.new{}
    @quantity = kw[:qtt] ? kw[:qtt] : 1
    @endure = kw[:endure] ? kw[:endure] : 10 # number of turns 'til it breaks
    @active = kw[:on] ? kw[:on] : true
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
  attr_accessor :desc, :short_desc, :atrb, :where,
                :inventory, :protagonist, :hp, :sp,
                :coins, :story
  attr_reader :name

  def initializer(name, **kw)
    @name = name
    @desc = kw[:desc] ? kw[:desc] : ""
    @short_desc = kw[:s_desc] ? kw[:s_desc] : ""
    @atrb = Hash.new{}
    @where = kw[:where]
    @inventory = kw[:inventory] ? kw[:inventory] : []
    @protagonist = kw[:protagonist] ? kw[:protagonist] : false
    @hp = kw[:hp] ? kw[:hp] : 100
    @sp = kw[:sp] ? kw[:sp] : 1
    @coins = kw[:coins] ? kw[:coins] : 30
    @story = kw[:story] ? kw[:story] : nil
    # Games.characters << self
  end

  def put_in_the_game
    self.story.characters << self
  end
  # def is_there_any_main
  # end

  def life_up_and_down(value, heal=true)
    # self.hp = 42
    if self.story.begun
      if heal
        self.hp += value
      else
        self.hp -= value
      end
      return true
    else
      false
    end
  end

  def strength_up_and_down(value, heat_up=true)
    if self.story.begun
      if heat_up
        self.sp += value
      else
        self.sp -= value
      end
      return true
    else
      false
    end
  end

  def money_up_and_down(value, income=true)
    if self.story.begun
      if income
        self.coins += value
      else
        self.coins -= value
      end
      return true
    else
      false
    end
  end

  def attack(target)
    if self.story.begun
      if self.sp > target.sp
        return true
      else
        return false
      end
    else
      return false
    end
  end

  def object_in_and_out(thing, get = 1)
    if self.story.begun
      
      return true
    else
      false
    end
  end

  def move to
    if self.story.begun
    end
  end
end

class Event < Element
  attr_accessor :moment, :local, :proc, :trigger,
                :done, :desc, :par, :lamb, :locked
  attr_reader :name

  def initialize (name="", desc="")
    @name = name
    @desc = desc
    @par = 0
    @local = Hash.new{} # local variables
    @locked = false
    @moment = -1
    @trigger = ""
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
