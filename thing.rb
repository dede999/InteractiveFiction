class Thing

  def initilize(nome, where, flags, attr, quantity = 1, desc, short, endurance = 10, on = true )
    @nome = nome
    @where = where
    @flags = flags
    @attr = attr
    @quantity = quantity
    @desc = desc
    @short_desc = short
    @endure = endurance
    @active = on
  end

  def move_stuff(to = self.where)

  end

  def activate

  end

  def deactivate

  end

end