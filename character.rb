class Character
  @@there_is_main = false

  def initializer(name, where, desc, short, attr, inv, is_protagonist = false , health = 100, strength = 0, money = 0)
    @name = name
    @where = where
    @desc = desc
    @short_desc = short
    @attr = attr
    @inventory = inv
    @protaginst = is_protagonist
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