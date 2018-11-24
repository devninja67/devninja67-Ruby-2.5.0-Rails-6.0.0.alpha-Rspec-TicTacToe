describe Match, :type => :model do

	let!( :player1 ) { SecureRandom.urlsafe_base64 }
  let!( :player2 ) { SecureRandom.urlsafe_base64 }

	describe "#create" do
		before do
			Match.clear_all
			Match.create(player1)
		end

		it "matches's value should be player1 after only one time call of create" do
			expect( REDIS.get( "matches" ) ).to eq( player1 )
		end

		it "Should call Game.start after two time call of create" do
      expect( Game ).to receive( :start ).with( player2, player1 )
      Match.create(player2)
		end

		context "After two time call of create, " do
			before do
				Match.create(player2)
			end

			it "matches's value should be nil at create's two time call" do
	      REDIS.get( "matches" ).should eql( "" )
			end
		end
	end

	describe "#remove" do
		before do
      REDIS.set( "matches", player1 )
		end

		context "When same id remove, " do
			before do
	      Match.remove( player1 )
			end

			it "matches's value should be nil" do
	      REDIS.get("matches").should eql( "" )
			end
		end

		context "When other id remove, " do
			before do
	      Match.remove( player2 )
			end

			it "matches's value should be not nil" do
	      REDIS.get("matches").should_not eql("")
			end
		end
	end

	describe "#clear_all" do
		before do
			Match.clear_all
		end

		it "'matches's value should be nil" do
			REDIS.get("matches").should be_nil
		end
	end

end