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
end
