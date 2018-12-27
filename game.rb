class Games

  attr_access :events
  def initilize(nome, intro, authors="", version, attr)
    @name = nome
    @intro = intro
    @authors = authors.split(",")
    @version = version
    @attr = attr
    @turns = 0
    @events = []
    @success = false
    @begun = false
      # @historic = []
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
