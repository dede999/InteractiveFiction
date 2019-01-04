require 'game'
require 'rspec'

describe Thing do

  before(:all) do
    @room = Rooms.new("Living")
    @room.south = Rooms.new("Bathroom")
    @room.south.is_locked = true
    @stuff = Thing.new("Test")
    @stuff.where = @room
    @stuff.active = false
    # @game = Games.new("Teste",
    #                   "", "", "")
  end

  it "could not be moved to some locked room" do
    resp = @stuff.move_stuff @room.south
    expect(resp).to be false
  end

  it "could be moved to some unlocked room" do
    @room.south.lock false
    @stuff.move_stuff @room.south
    expect(@stuff.where).to eq(@room.south)
  end

  it "should not be worn if it's inactive" do
    used = @stuff.use
    expect(used).to be false
  end

  it "should be worn it it's active" do
    var = @stuff.endure
    @stuff.use
    expect(@stuff.endure).to be < var
  end

  it "must be inactive if its endurance is 0 (broken)" do
    @stuff.endure = 1
    @stuff.use
    expect(@stuff.active).to be false
    expect(@stuff.endure).to be 0
  end

  it "should not be activated if it's broken" do
    on = @stuff.activate true
    expect(on).to be false
  end

  it "should increase endurance after repair" do
    var = @stuff.endure
    @stuff.repair 5
    expect(@stuff.endure).to be > var
  end

  it "should increase endurance value by some determined value" do
    bef = @stuff.endure
    @stuff.repair 10
    aft = @stuff.endure
    expect(aft - bef).to be 10
  end
end
