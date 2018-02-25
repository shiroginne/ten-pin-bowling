require "rails_helper"

RSpec.describe Games::MakeTurnsController, type: :routing do
  describe "routing" do
    it "routes to #create" do
      expect(post: "/games/1/turns").to route_to("games/make_turns#create", game_id: "1")
    end
  end
end
