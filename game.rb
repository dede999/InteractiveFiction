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

  def initilize(nome, intro, authors="", version, attr)
    super(nome, attr)
    @intro = intro
    @authors = authors.split(",")
    @version = version
    @turns = 0
    @events = []
    @success = false
    @begun = false
    @historic = []
  end

  def start

  end

  def new_turn

  end

  def prompt

  end

  def end_game

  end
end

class Rooms < Element
  attr_accessor :name, :north, :east, :west, :south, :flags, :stuff_there, :is_locked

  def initialize (n, s, w, e, locked = false)
    super
    @north = n
    @south = s
    @west = w
    @east = e
    @stuff_there = []
    @is_locked = locked
  end

  def lock

  end

  def unlock

  end
end

class Thing < Element

  def initilize(nome, where, flags, attr, quantity, desc, short, endurance, on = true )
    super
    @where = where
    @quantity = quantity
    @endure = endurance
    @active = on
  end

  def move_stuff(to = self.where)
    to
  end

  def activate

  end

  def deactivate

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

  def initialize (vars, proc, moment, trigger)
    # @name = name
    # @desc = desc
    super
    @attr = vars
    @proc = proc
    @moment = moment
    @trigger = trigger
  end

  def make_it_happen
    # execute procedure
  end

  def activate_trigger
    # test trigger condition
  end
end
