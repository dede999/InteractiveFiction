require 'game'
require 'rspec'

describe Character do

  before(:all) do
    @bed = Rooms.new("Bedrrom")
    @stuff = Thing.new("Piece of Heaven")
    @stuff.where = @bed
    @stuff.quantity = 3
    @per = Character.new("Dude", @bed)
    @bad = Character.new("Bad Guy", @bed)
    @game = Games.new("test", "intro","1")
    @per.protagonist = true
    @per.sp = 25
    @bad.sp = 20
  end

  context "making sure none of these things happen if game ain't started" do
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
  end

  context "when testing life_up_and_down" do
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
  end

  context "when testing strength_up_and_down" do
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
  end

  context "when testing money_up_and_down" do
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

  context "testing attack method" do
    it "should not be able to hit target if weaker than target" do
      var = @bad.attack @per
      expect(var).to be false
    end

    it "should be able to hit target if weaker than target" do
      var = @per.attack @bad
      expect(var).to be true
    end
  end

  context "testing object_in_and_out" do
    it "should give a character an object" do
      @per.object_in_and_out(@stuff, 2)
      expect(@per.inventory).to eq([@stuff])
      expect(@per.inventory[0].quantity).to eq 2
      expect(@bed.stuff_there[0].quantity).to eq 1
    end

    it "should not allow a character to give something it doesn't have" do
      var = @per.object_in_and_out @stuff, -3
      expect(var).to be false
    end

    it "should be able to drop objects (diminish quantity)" do
      @per.object_in_and_out @stuff, -1
      expect(@per.inventory[0].quantity).to eq 1
    end
  end
end