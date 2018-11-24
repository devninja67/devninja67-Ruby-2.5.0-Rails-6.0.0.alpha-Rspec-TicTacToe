describe Match, :type => :model do
	describe "method clear_all" do
		it "after clear_all, index( matches ) value should be nil" do
			Match.clear_all
			REDIS.get("matches").should be_nil
		end

	end

	describe "method create" do
		it "matches should set uuid at create's one time call" do
			uuid = SecureRandom.urlsafe_base64
			Match.create(uuid)
			expect( REDIS.get("matches") ).to eq( uuid )
			
		end

		it " !@!@!@!@!@should call game::start at create's two time call" do
			Match.clear_all
			player1 = SecureRandom.urlsafe_base64
			Match.create(player1)
			player2 = SecureRandom.urlsafe_base64
      expect( Game ).to receive( :start ).with( player2, player1 )
      Match.create(player2)

		end

		it "matches should set nil at create's two time call" do
			uuid = SecureRandom.urlsafe_base64
			Match.create(uuid)
			uuid = SecureRandom.urlsafe_base64
			Match.create(uuid)
      REDIS.get("matches").should eql( "" )
		end

	end

	describe "method remove" do
		it "if uuid is same with index matches, then after remove, matches index should be nil" do
			uuid = SecureRandom.urlsafe_base64
      REDIS.set("matches", uuid)
      Match.remove(uuid)
      REDIS.get("matches").should eql( "" )

		end

		it "if uuid is different with index matches, then after remove, matches index should be not nil" do
			uuid1 = SecureRandom.urlsafe_base64
      REDIS.set("matches", uuid1)
			uuid2 = SecureRandom.urlsafe_base64
      Match.remove(uuid2)
      REDIS.get("matches").should_not eql("")

		end

	end

end