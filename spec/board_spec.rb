require "lib/board"

describe Board do
  subject(:board) {described_class.new}

  describe "#initialize" do
    it "should have an empty board" do
      expect(board.grid).to eq([nil, nil, nil, nil, nil, nil, nil, nil, nil])
    end
  end
end
