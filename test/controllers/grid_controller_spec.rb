require 'spec_helper'

# class GridControllerTest < ActionDispatch::IntegrationTest
#   # test "the truth" do
#   #   assert true
#   # end
# end

RSpec.describe grid, type: :controller do
  describe "GET index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end
end