require "lib/tictactoe"

describe TicTacToe do
  subject(:tictactoe) {described_class.new}

  context "New Game" do
    describe "#initialize" do
      it "should have an empty board" do
        expect(tictactoe.board).to eq([nil, nil, nil, nil, nil, nil, nil, nil, nil])
      end
    end

    describe "#play" do
      it "should allow player 1 to play counter in slot 0" do
        tictactoe.play(0)
        expect(tictactoe.board).to eq([true, nil, nil, nil, nil, nil, nil, nil, nil])
      end

      it "should allow player 1 to play counter in slot 3" do
        tictactoe.play(3)
        expect(tictactoe.board).to eq([nil, nil, nil, true, nil, nil, nil, nil, nil])
      end

      it "should allow player 1 to play counter in slot 0 and player 2 in slot 3" do
        tictactoe.play(0)
        tictactoe.play(3)
        expect(tictactoe.board).to eq([true, nil, nil, false, nil, nil, nil, nil, nil])
      end

      it "should raise an error if a player tries to play in a used slot" do
        tictactoe.play(0)
        expect{tictactoe.play(0)}.to raise_error("Slot in use")
      end

      it "should raise an error if there are no more slots available" do
        (0..7).each {|i| tictactoe.play(i)}
        expect(tictactoe.play(8)).to eq("Game draw!")
      end
    end

    describe "Game winning" do
      it "Player 1 can win horizontally slots [0,1,2]" do
        data = [0,3,1,4]
        data.each {|i| tictactoe.play(i)}
        expect(tictactoe.play(2)).to eq("Player X won!")
        expect(tictactoe.board).to eq([true, true, true, false, false, nil, nil, nil, nil])
      end

      it "Player 2 can win horizontally slots [3,4,5]" do
        data = [0,3,1,4,8]
        data.each {|i| tictactoe.play(i)}
        expect(tictactoe.play(5)).to eq("Player O won!")
        expect(tictactoe.board).to eq([true, true, nil, false, false, false, nil, nil, true])
      end

      it "Player 1 can win horizontally slots [6,7,8]" do
        data = [6,3,7,4]
        data.each {|i| tictactoe.play(i)}
        expect(tictactoe.play(8)).to eq("Player X won!")
        expect(tictactoe.board).to eq([nil, nil, nil, false, false, nil, true, true, true])
      end

      it "Player 1 can win vertically slots [0,3,6]" do
        data = [0,1,3,4]
        data.each {|i| tictactoe.play(i)}
        expect(tictactoe.play(6)).to eq("Player X won!")
        expect(tictactoe.board).to eq([true, false, nil, true, false, nil, true, nil, nil])
      end

      it "Player 2 can win vertically slots [1,4,7]" do
        data = [0,1,2,4,3]
        data.each {|i| tictactoe.play(i)}
        expect(tictactoe.play(7)).to eq("Player O won!")
        expect(tictactoe.board).to eq([true, false, true, true, false, nil, nil, false, nil])
      end

      it "Player 1 can win vertically slots [2,5,8]" do
        data = [2,1,5,4]
        data.each {|i| tictactoe.play(i)}
        expect(tictactoe.play(8)).to eq("Player X won!")
        expect(tictactoe.board).to eq([nil, false, true, nil, false, true, nil, nil, true])
      end

      it "Player 1 can win diagonally [0,4,8]" do
        data = [0,2,4,5]
        data.each {|i| tictactoe.play(i)}
        expect(tictactoe.play(8)).to eq("Player X won!")
        expect(tictactoe.board).to eq([true, nil, false, nil, true, false, nil, nil, true])
      end

      it "Player 2 can win diagonally [2,4,6]" do
        data = [1,2,5,4,7]
        data.each {|i| tictactoe.play(i)}
        expect(tictactoe.play(6)).to eq("Player O won!")
        expect(tictactoe.board).to eq([nil, true, false, nil, false, true, false, true, nil])
      end
    end

    describe "Invailid input" do
      it "should not be able to select a slot less than 0" do
        expect{tictactoe.play(-1)}.to raise_error("Slot out of range")
      end

      it "should not be able to select a slot greater than 8" do
        expect{tictactoe.play(9)}.to raise_error("Slot out of range")
      end
    end
  end

end
