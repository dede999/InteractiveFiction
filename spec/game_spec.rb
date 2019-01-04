require 'game'
require 'rspec'

describe Games do

  before(:all) do
    e1 = Event.new
    e2 = Event.new
    e3 = Event.new
    e1.moment = 4
    e2.moment = 7
    e3.moment = 2
    @game = Games.new('Zork', '', '')
    @game.turns = 4
    @game.events = [e1, e2, e3]
    @game.begun = false
    @game.historic = ['Be happy']
    # allow(@game).to receive(:turns) {4}
    # allow(@game).to receive(:events) {[e1, e2, e3]}
  end

  it "should set 'begun' game attribute true" do
    @game.start
    expect(@game.begun).to be true
    expect(@game.success).to be false
  end

  it "should empty last games prompt history" do
    @game.start
    expect(@game.historic).to eq([])
  end

  it "should set the game turns value to zero" do
    @game.start
    expect(@game.turns).to eq 0
  end

  it "should schedule the events properly" do
    @game.schedule_tasks
    expect(@game.events[0].moment).to be <= @game.events[1].moment
    expect(@game.events[1].moment).to be <= @game.events[2].moment
  end

  it "should increment number of turns by one" do
    @game.new_turn
    expect(@game.turns).to eq 1
  end

  it "should not remove any task at 1st turn" do
    ev =  @game.pop_task
    expect(ev).to be_nil
  end

  it "should remove the first event at 2nd turn" do
    ev = @game.new_turn
    expect(ev).to be true
  end

  it "should end the game with a win" do
    @game.end_game
    expect(@game.begun).to be false
    expect(@game.success).to be true
  end

  it "should end the game with a loss" do
    @game.start
    @game.end_game false
    expect(@game.begun).to be false
    expect(@game.success).to be false
  end

end