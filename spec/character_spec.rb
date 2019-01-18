require 'game'
require 'rspec'

describe Character do

  before(:all) do
    @bed = Rooms.new("Bedrrom")
    @bath = Rooms.new("Bathroom")
    @bath.is_locked = true
    @stuff = Thing.new("Piece of Heaven")
    @stuff.where = @bed
    @stuff.quantity = 3
    @game = Games.new("test")
    @per = Character.new("Dude", where: @bed)
    @bad = Character.new("Bad Guy", where: @bed)
    @per.story = @game
    @bad.story = @game
    # @per.protagonist = true
    @per.put_in_the_game()
    # @per.hp = 40
    @per.sp = 25
    @bad.sp = 20
    # @per.coins = 2
  end

  context "making sure we can 'reach' instance atributes" do
    it "can reach name attr" do
      var = @per.name
      expect(var).to eq "Dude"
    end

    it "can reach description" do
      var = @per.desc
      @per.desc = "LOLOLOLOL"
      expect(var).to eq ""
      expect(@per.desc).to eq "LOLOLOLOL"
    end

    it "can reach short description" do
      expect(@per.short_desc).to eq ""
      @per.short_desc = "Blah Blah"
      expect(@per.short_desc).to eq "Blah Blah"
    end

    it "can reach atributes" do
      expect(@per.atrb).to eq({})
      @per.atrb["a"] = 1
      expect(@per.atrb).to eq({"a" => 1})
    end

    it "can reach loction" do
      expect(@per.where).to be(@bed)
      @per.where = @bath
      expect(@per.where).to be(@bath)
      @per.where = @bed
    end

    it "can reach inventory" do
      var = @per.inventory
      expect(var).to be([])
      @per.inventory = [Thing.new("abba")]
      expect(@per.inventory[0].name).to be "abba"
    end

    it "can reach protagonist" do
      var = @bad.protagonist
      expect(var).to be(false)
      @bad.protagonist = true
      expect(@bad.protagonist).to be true
    end
    
    it "can reach hp" do
      var = @per.hp
      expect(var).to be 100
      @per.hp -= 10
      expect(@per.hp).to be < var
    end
    
    it "can reach sp" do
      var = @per.sp
      expect(var).to be 100
      @per.sp -= 10
      expect(@per.sp).to be < var
    end
    
    it "can reach coins" do
      var = @per.coins
      expect(var).to be 100
      @per.coins -= 10
      expect(@per.coins).to be < var
    end
    
    it "can reach story" do
      var = @per.story
      expect(var.nome).to be "teste"
    end
  end

  context "making sure anything happen if game ain't started" do
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

    it 'should not walk if game is not started' do
      var = @per.move @stuff
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

  context "walking around" do
    it "should not go to a locked room" do
      var = @per.move @bath
      expect(var).to be false
    end

    it "should go to other room if its locked" do
      @bath.lock(false)
      @per.move @bath
      expect(@per.where.name).to be "Bathroom"
    end
  end
end