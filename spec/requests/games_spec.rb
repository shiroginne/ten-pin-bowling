require 'rails_helper'

RSpec.describe "Games", type: :request do
  describe "GET /games/1" do
    let(:params) do
      attributes_for(:game).merge(players_attributes: [attributes_for(:player)])
    end
    let(:game) { Game.create(params) }

    it "returns game information" do
      get game_path(id: game.id, format: :json)
      game_data = JSON.parse(response.body)

      %w(id title url object players frames).each { |key| expect(game_data).to include(key) }
      %w(created_at updated_at).each { |key| expect(game_data).not_to include(key) }
    end

    it "returns frames and scores" do
      frame = game.frames.first
      TurnMaker.make_turn(frame, 10)

      get game_path(id: game.id, format: :json)
      game_data = JSON.parse(response.body)

      closed_frame = game_data["frames"].find { |f| f["id"] == frame.id }
      %w(game_id player_id state score object).each do |key|
        expect(closed_frame).to include(key)
      end
      expect(closed_frame["score"]).to eq(10)
      expect(closed_frame["state"]).to eq("closed")
      expect(closed_frame["url"]).to eq(game_frame_url(frame.game, frame, format: :json))
    end
  end
end
