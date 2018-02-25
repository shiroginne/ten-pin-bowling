require 'rails_helper'

RSpec.describe Frame, type: :model do
  describe "#state" do
    let(:frame) { build(:frame) }

    it "open by default" do
      expect(frame.state).to eq("open")
    end

    context "closed" do
      let(:player) { create(:player) }
      let(:game) { create(:game, players: [player]) }

      it "creates new frame if current is closed" do
        expect(game.frames.count).to eq(1)

        frame = create(:frame, game: game, player: player)
        expect(game.frames.count).to eq(2)

        frame.close!
        expect(game.frames.count).to eq(3)
      end
    end
  end

  describe "#last?" do
    let(:game) { create(:game_with_players) }

    context "from 1 till 9 frame" do
      it "returns false" do
        frame = create(:frame, game: game)
        expect(frame.last?).to eq(false)
      end
    end

    context "for 10th frame" do
      it "returns true" do
        8.times { create(:frame, game: game) }
        frame = create(:frame, game: game)

        expect(frame.last?).to eq(true)
      end
    end
  end
end
