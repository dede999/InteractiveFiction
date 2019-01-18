require 'game'
require 'rspec'

describe Element do

  before(:each) do
    att_hash = Hash.new
    att_hash["word"] = "okay"
    flag = {"on" => true }
    @example = Element.new('test')
    @example.atrb = att_hash
    @example.flags = flag
  end

  context "when testing basic methods" do
    it 'should be able to change variables' do
      @example.change_variables("word", "test")
      expect(@example.attr["word"]).to eq("test")
    end

    it "should modify a flag value" do
      @example.modify("on")
      expect(@example.flags["on"]).to be false
    end
  end
end