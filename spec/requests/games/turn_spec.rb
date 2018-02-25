require 'rails_helper'

RSpec.describe "Turns", type: :request do
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
      expect(turn_data["score"]).to eq(8)
      expect(turn_data["state"]).to eq("open")
      expect(turn_data["turns"].first["pins_count"]).to eq(8)
    end

    context "when closes frame" do
      it "returns url for the next frame" do
        params[:pins_count] = 5
        2.times { post game_turns_path(params) }
        turn_data = JSON.parse(response.body)

        expect(turn_data["game_id"]).to eq(game.id)
        expect(turn_data["score"]).to eq(10)
        expect(turn_data["next"]["url"]).to eq(game_frame_url(game, game.next_frame, format: :json))
      end
    end

    context "with invalid params" do
      it "returns error" do
        params[:player_id] = nil

        post game_turns_path(params)
        turn_data = JSON.parse(response.body)

        expect(turn_data["error"]["id"]).to eq("404")
      end
    end
  end
end
