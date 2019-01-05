require 'game'
require 'rspec'

describe Character do

  before(:all) do
    bed = Rooms.new("Bedrrom")
    @stuff = Thing.new("Piece of Heaven")
    @stuff.where = bed
    @per = Character.new("Dude", bed)
    @bad = Character.new("Bad Guy", bed)
    @game = Games.new("test", "intro","1")
    @per.protagonist = true
  end

  it "should not hurt or heal if the game is not started" do
    var = @per.life_up_and_down 5
    expect(var).to be false
  end

  it "should not weaken or strength if the game is not started" do
    var = @per.strength_up_and_down 5
    expect(var).to be false
  end

  it "should not get or lose money if the game is not started" do
    var = @per.money_up_and_down 5
    expect(var).to be false
  end

  it "should not attack if the game is not started" do
    var = @per.attack @bad
    expect(var).to be false
  end

  it "should not get anything if the game is not started" do
    var = @per.object_in_and_out @stuff
    expect(var).to be false
  end

  it "should hurt a character" do
    @game.start
    var = @per.hp
  	@per.life_up_and_down(1, false)
    expect(@per.hp).to be < var
  end

  it "should heal a character" do
    var = @per.hp
    @per.life_up_and_down(1)
    expect(@per.hp).to be > var
  end

  it "should strengthen a character" do
    var = @per.sp
    @per.strength_up_and_down(1)
    expect(@per.sp).to be > var
  end

  it "should weaken a character" do
    var = @per.sp
    @per.strength_up_and_down(1, false )
    expect(@per.sp).to be < var
  end

  it "should give money to a character" do
    var = @per.coins
    @per.money_up_and_down(1)
    expect(@per.coins).to be > var
  end

  it "should take money from a character" do
    var = @per.coins
    @per.money_up_and_down(1, false )
    expect(@per.coins).to be < var
  end
end