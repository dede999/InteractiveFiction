require 'game'
require 'rspec'

describe Rooms do

  before(:all) do
    t1 = Thing.new("Mesa")
    t2 = Thing.new("Luminária")
    t3 = Thing.new("Cadeira")
    @room = Rooms.new("Quarto Escuro", stuff: [t1, t2, t3])
    @north = Rooms.new("Sala")
    @south = Rooms.new("Quintal")
    @room.north = @north
    @room.south = @south
    @north.is_locked = true
  end

  it 'should look around' do
      around = @room.look_around
      expect(around).to eq("Mesa Luminária Cadeira ")
  end

  context "testing unlock" do
    it "should be able to unlock if its locked" do
      @north.lock false
      expect(@north.is_locked).to be false
    end

    it "should not be able to unlock if its already unlocked" do
      var = @south.lock false
      expect(var).to be false
    end
  end

  context "testing lock" do
    it "should be able to lock if its unlocked" do
      @south.lock true
      expect(@south.is_locked).to be true
    end

    it "should not be able to lock if its already locked" do
      @north.is_locked = true
      var = @north.lock true
      expect(var).to be false
    end
  end

end