require 'rails_helper'

RSpec.describe Player, type: :model do
  describe "validations" do
    subject(:player) { Player.create(params) }

    context "with valid params" do
      let(:params) { { name: "John Snow" } }

      it "creates new player" do
        expect(player.valid?).to be(true)
        expect(player.persisted?).to be(true)
      end
    end

    context "with invalid params" do
      let(:params) { { name: "Jo" } }

      it "returns errors" do
        expect(player.valid?).to be(false)
        expect(player.errors.messages[:name])
          .to eq(["is too short (minimum is 3 characters)"])
      end
    end
  end
end
