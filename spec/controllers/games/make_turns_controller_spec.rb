require 'rails_helper'

RSpec.describe Games::MakeTurnsController, type: :controller do
  describe "POST #create" do
    let(:game) { create(:game_with_players) }
    let(:player) { game.players.first }
    let(:frame) { game.frames.first }
    let(:params) {
      {
        game_id: game.id,
        player_id: player.id,
        frame_id: frame.id,
        pins_count: 8
      }
    }

    it "makes turn for player" do
      post :create, params: params.merge(format: :json)

      expect(response).to have_http_status(:created)
      expect(response.content_type).to eq("application/json")
      expect(response.location).to eq(game_frame_url(game, frame))
    end

    it "creates new frame" do
      2.times { post :create, params: params.merge(format: :json) }

      expect(game.frames.count).to eq(2)
      expect(game.frames.current.player).to eq(Current.player)
    end
  end
end
