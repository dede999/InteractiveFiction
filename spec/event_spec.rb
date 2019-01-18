require 'game'
require 'rspec'

describe Event do

  before(:all) do
    @event = Event.new("Test Event",
                       "")
    @event.desc = "while var < p1\n var += 1\n print black
\n end \n while var < 5 \n var += 1 \n print white \n end \n"
    @event.local["var"] = 0
    @event.local["black"] = 1
    @event.local["white"] = 0
    @event.par = 1
    @event.locked = true
  end

  context "when testing create_procedure" do
    it "should create the lambda text correctly" do
      @event.create_procedure
      expect(@event.lamb).to be "lambda {|var = 0, black = 1, white = 0, p1| while var < p1\nprint black\nvar += 1\nend\nwhile var < 5\nprint white\nvar += 1\nend}"
    end

    it "should create a procedure" do
      expect(@event.proc.class).to be_an_instance_of Proc
    end
  end

  context "when testing make_it_happen" do
    it "should not execute if its locked" do
      var = @event.make_it_happen
      expect(var).to be false
    end

    it "should rise an Argument Error if no argument given (if it needs any" do
      @event.cond = "lambda {return true}"
      expect(@event.make_it_happen).to raise(ArgumentError)
    end
  end
end