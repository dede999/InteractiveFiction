class Event

  def initialize (name, desc, vars, proc, moment, trigger)
    @name = name
    @desc = desc
    @local = vars
    @proc = proc
    @moment = moment
    @trigger = trigger
  end

end