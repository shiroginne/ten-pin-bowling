require 'rails_helper'

RSpec.describe ScoreUpdater do
  describe "#score" do
    let(:game) { create(:game_with_players) }
    let(:frame) { create(:frame, game: game) }

    context "spare turn" do
      it "calculates amount of pins" do
        frame.turns.create(pins_count: 2)
        expect(frame.score).to eq(2)

        frame.turns.create(pins_count: 8)
        expect(frame.score).to eq(10)
      end

      context "next frame" do
        it "adds score from first turn of next frame" do
          2.times { frame.turns.create(pins_count: 5) }

          next_frame = game.frames.open.first
          next_frame.turns.create(pins_count: 5)
          next_frame.turns.create(pins_count: 3)

          frame.reload
          expect(next_frame.score).to eq(8)
          expect(frame.score).to eq(15)
        end
      end
    end

    context "strike" do
      it "assigns 10" do
        frame.turns.create(pins_count: 10)
        expect(frame.score).to eq(10)
      end

      it "calculates next frames with current" do
        frame.turns.create(pins_count: 10)

        next_frame = game.frames.open.first
        next_frame.turns.create(pins_count: 5)
        next_frame.turns.create(pins_count: 3)

        frame.reload
        expect(next_frame.score).to eq(8)
        expect(frame.score).to eq(18)
      end
    end
  end
end
