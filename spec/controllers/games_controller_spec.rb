require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  let(:valid_attributes) do
    attributes_for(:game).merge(players_attributes: [attributes_for(:player)])
  end
  let(:invalid_attributes) { { title: "GO" } }

  describe "GET #show" do
    let(:game) { Game.create! valid_attributes }

    it "returns a success response" do
      get :show, params: { id: game.to_param, format: :json }

      expect(response.successful?).to eq(true)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Game" do
        expect {
          post :create, params: { game: valid_attributes, format: :json }
        }.to change(Game, :count).by(1)
      end

      it "renders a JSON response with the new game" do
        post :create, params: { game: valid_attributes, format: :json}

        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(game_url(Game.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new game" do
        post :create, params: { game: invalid_attributes, format: :json }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PUT #update" do
    let(:game) { Game.create! valid_attributes }

    context "with valid params" do
      let(:new_attributes) { { title: "Altered Carbon" } }

      it "updates the requested game" do
        put :update, params: { id: game.to_param, game: new_attributes, format: :json }

        game.reload
        expect(game.title).to eq(new_attributes[:title])
      end

      it "renders a JSON response with the game" do
        put :update, params: { id: game.to_param, game: valid_attributes, format: :json }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the game" do
        put :update, params: { id: game.to_param, game: invalid_attributes, format: :json }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end
end
