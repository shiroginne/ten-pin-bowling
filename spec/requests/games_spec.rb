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

      %w(id title url object players).each { |key| expect(game_data).to include(key) }
      %w(created_at updated_at).each { |key| expect(game_data).not_to include(key) }
    end
  end

  describe "POST /game/1/turn" do
    let(:game) { create(:game_with_players) }
    let(:player) { game.players.first }
    let(:params) {
      {
        game_id: game.id,
        player_id: player.id,
        frame_id: game.frames.first.id,
        pins_count: 8,
        format: :json
      }
    }

    it "makes turn for player" do
      post game_turns_path(params)
      turn_data = JSON.parse(response.body)

      expect(turn_data["game_id"]).to eq(game.id)
      expect(turn_data["player_id"]).to eq(player.id)
      expect(turn_data["turns"].first["pins_count"]).to eq(8)
    end
  end
end
