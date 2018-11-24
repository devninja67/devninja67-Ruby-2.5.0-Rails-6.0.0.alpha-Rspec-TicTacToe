require_relative 'board'

class TicTacToe
  WinningLines = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

  attr_reader :board

  def initialize(board=Board.new)
    @board = board.grid
    @player = true
  end

  def play(slot=0)
    raise "Slot out of range" if slot_out_of_range?(slot)
    raise "Slot in use" if slot_in_use?(slot)
    @board[slot] = @player
    return "Game draw!" if no_slots_available?
    return @winner_text if check_winning_line
    next_player
  end

  private

  def next_player
    @player = !@player
  end

  def slot_in_use?(slot)
    @board[slot] != nil
  end

  def no_slots_available?
    !@board.include? nil
  end

  def check_winning_line
    WinningLines.each do |winner|
      line_win = 0
      winner.each {|slot| line_win += 1 if @board[slot]==@player}
      return who_won if line_win == 3
    end
    false
  end

  def who_won
    @winner_text = "Player "
    @winner_text += @player ? "X" : "O"
    @winner_text += " won!"
  end

  def slot_out_of_range?(slot)
    slot < 0 || slot > 8
  end

end
