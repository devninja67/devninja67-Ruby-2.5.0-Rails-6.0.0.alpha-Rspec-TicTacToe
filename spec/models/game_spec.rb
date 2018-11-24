# require 'test_helper'

# class GameTest < ActiveSupport::TestCase
#   # test "the truth" do
#   #   assert true
#   # end
# end

describe Game, :type => :model do

  describe "Method opponent_for" do
    it "opponent_for result should be same with REDIS.get.." do 
      player1 = SecureRandom.urlsafe_base64
      player2 = SecureRandom.urlsafe_base64
      REDIS.set( "opponent_for:#{ player1 }", player2 )
      expect( Game.opponent_for( player1 ) ).to eq( REDIS.get( "opponent_for:#{ player1 }" ) )

    end

    it "opponent_for result should be same with REDIS.get.." do 
      player1 = SecureRandom.urlsafe_base64
      player2 = SecureRandom.urlsafe_base64
      REDIS.set( "opponent_for:#{ player1 }", player2 )
      expect( Game.opponent_for( player1 ) ).to eq( player2 )

    end

  end

	describe "method start" do
    it "Player1's opponent should be Player2 after method start" do
      player1 = SecureRandom.urlsafe_base64
      player2 = SecureRandom.urlsafe_base64
      Game.start( player1, player2 )
      expect( Game.opponent_for( player1 ) ).to eq( player2 )

    end

    it "Player2's opponent should be Player1 after method start" do
      player1 = SecureRandom.urlsafe_base64
      player2 = SecureRandom.urlsafe_base64
      Game.start( player1, player2 )
      expect( Game.opponent_for( player2 ) ).to eq( player1 )

    end

	end

  describe "Method take_turn" do
    it "should be called broadcast" do
      player1 = SecureRandom.urlsafe_base64
      player2 = SecureRandom.urlsafe_base64
      Game.start( player1, player2 )
      move = {data:"1 2"}
      param1 = "player_#{player2}"
      param2 = {action: "take_turn", move: move['data']}
      expect( ActionCable.server ).to receive( :broadcast ).with( param1, param2 )
      Game.take_turn(player1,move)

    end

  end

  describe "Method new_game" do
    it "should be called broadcast with player1, its opponent" do
      player1 = SecureRandom.urlsafe_base64
      player2 = SecureRandom.urlsafe_base64
      Game.start( player1, player2 )
      param1 = "player_#{player2}"
      param2 = {action: "new_game"}
      expect( ActionCable.server ).to receive( :broadcast ).with( param1, param2 ) 
      Game.new_game(player1)

    end

  end

end