require 'rails_helper'

RSpec.describe Game, type: :model do
  describe "validations" do
    subject(:game) { Game.create(params) }

    context "with valid params" do
      let(:params) do
        attributes_for(:game).merge(players_attributes: [attributes_for(:player)])
      end

      it "creates new game" do
        expect(game.valid?).to be(true)
        expect(game.persisted?).to be(true)
      end
    end

    context "with invalid params" do
      let(:params) { { title: "GO" } }

      it "returns errors" do
        expect(game.valid?).to be(false)
        expect(game.errors.messages[:title])
          .to eq(["is too short (minimum is 3 characters)"])
      end
    end
  end
end
