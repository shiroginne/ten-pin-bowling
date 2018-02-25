require 'rails_helper'

RSpec.describe FrameCloser do
  describe "#close!" do
    let(:player) { create(:player) }
    let(:game) { create(:game, players: [player]) }

    it "creates new frame if current is closed" do
      expect(game.frames.count).to eq(1)

      frame = game.frames.first
      2.times { frame.turns.create(pins_count: 5) }

      expect(game.frames.count).to eq(2)
    end
  end
end
