class Element
  attr_accessor :attr, :flags, :desc, :short
  attr_reader :nome

  def initialize(nome, attr = Hash.new{}, flags = Hash.new{}, desc, short)
    @name = nome
    @attr = attr
    @flags = flags
    @desc = desc
    @short = short
  end

  def change_variables (var, new_var)
    # change attr hash
  end

  def modify flag
    # make flag value the opposite
    # flag hash values are boolean
  end
end

class Games < Element
  attr_accessor :events, :turns, :success, :begun, :historic
  attr_reader :intro, :authors, :version

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

  def start

  end

  def new_turn

  end

  def schedule_tasks

  end

  def pop_task

  end

  def end_game(win=true)

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

  end

  def look_around
    ""
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
    ""
  end

  def activate yes

  end

  def use

  end

  def repair rr

  end

end

class Character < Element
  @@there_is_main = false

  def initializer(name, where, desc, short, attr, inv, is_protagonist = false , health = 100, strength = 0, money = 0)
    # @name = name
    # @desc = desc
    # @short_desc = short
    # @attr = attr
    super
    @where = where
    @inventory = inv
    @protagonist = is_protagonist
    @hp = health
    @sp = strength
    @coins = money
    if is_protagonist and not @@there_is_main
      @@there_is_main = true
    end
  end

  def is_there_any_main
    @@there_is_main
  end

  def life_up_and_down(value, up=true)

  end

  def strength_up_and_down(value, up=true)

  end

  def money_up_and_down(value, up=true)

  end

  def attack(target)

  end

  def object_in_and_out(thing, qtt = 1)

  end

  def set_flag(title, to_state = 0)

  end
end

class Event < Element
  attr_accessor :moment, :local, :proc, :trigger, :done
  attr_reader :name, :desc

  def initialize (name="", desc="")
    @name = name
    @desc = desc
    @local = Hash.new{} # local variables
    @proc = Proc.new{}
    @moment = -1
    @trigger = Proc.new{}
    @done = false
  end

  def make_it_happen
    # execute procedure
  end

  def activate_trigger
    # test trigger condition
  end
end
