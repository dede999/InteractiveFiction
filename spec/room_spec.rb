require 'game'
require 'rspec'

describe Rooms do

  before(:all) do
    t1 = Thing.new("Mesa")
    t2 = Thing.new("Luminária")
    t3 = Thing.new("Cadeira")
    @room = Rooms.new("Quarto Escuro")
    @north = Rooms.new("Sala")
    @south = Rooms.new("Quintal")
    @room.stuff_there = [t1, t2, t3]
    @room.north = @north
    @room.south = @south
    @north.is_locked = true
  end

  it 'should look around' do
      around = @room.look_around
      expect(around).to eq("Mesa, Luminária, Cadeira")
  end

  # it "should not go to a locked room" do
  # end
  it "should be able to unlock" do
    @north.lock false
    expect(@north.is_locked).to be false
  end

  it "should be able to lock" do
    @south.lock true
    expect(@south.is_locked).to be true
  end

end