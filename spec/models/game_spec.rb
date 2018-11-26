describe Game, :type => :model do
  
  let!( :player1 ) { SecureRandom.urlsafe_base64 }
  let!( :player2 ) { SecureRandom.urlsafe_base64 }

  describe "#start" do

    # before do
    #   Game.start( player1, player2 )
    # end

    let! ( :param11 ) { "player_#{player1}" }
    let! ( :param12 ) { "player_#{player2}" }
    let! ( :param21 ) { { action: "game_start", msg: "cross" } }
    let! ( :param22 ) { { action: "game_start", msg: "nought" } }

    it "Broadcast for player with Cross( X ) be called after start" do
      expect( ActionCable.server ).to receive( :broadcast ).at_least(:twice).with( ( eq(param11).or eq(param12) ), ( eq(param21).or eq(param22) ) )
      Game.start( player1, player2 )
    end

    it "Player1's opponent should be Player2 after method start" do
      Game.start( player1, player2 )
      expect( Game.opponent_for( player1 ) ).to eq( player2 )
    end

  end

  describe "#withdraw" do
    before do
      Match.clear_all
      Match.create(player1)
      Match.create(player2)
    end

    let!( :param1 ) { "player_#{player2}" }
    let!( :param2 ) { { action: "opponent_withdraw" } }

    it "Should be called broadcast(action:withdraw) after withdraw" do
      expect( ActionCable.server ).to receive( :broadcast ).with( param1, param2 )
      Game.withdraw( player1 )
    end
  end

  describe "#opponent_for" do
    it "opponent_for( player1 ) should return player2" do 
      REDIS.set( "opponent_for:#{ player1 }", player2 )
      expect( Game.opponent_for( player1 ) ).to eq( player2 )
    end
  end

  describe "#take_turn" do

    let!( :param1 ) { "player_#{player2}" }
    let!( :param2 ) { { action: "take_turn", move: move['data'] } }
    let!( :move ) { { data:"1 2" } }

    before do
      Game.start( player1, player2 )
    end

    it "should be called broadcast(action:take_turn) after take_turn" do
      expect( ActionCable.server ).to receive( :broadcast ).with( param1, param2 )
      Game.take_turn( player1, move )
    end
  end

  describe "#new_game" do

    let!( :param1 ) { "player_#{player2}" }
    let!( :param2 ) { { action: "new_game" } }

    before do
      Game.start( player1, player2 )
    end

    it "should be called broadcast(action:new_game) after new_game" do
      expect( ActionCable.server ).to receive( :broadcast ).with( param1, param2 ) 
      Game.new_game( player1 )
    end
  end

end