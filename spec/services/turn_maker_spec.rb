require 'rails_helper'

RSpec.describe TurnMaker do
  describe "#make_turn" do
    let(:frame) { create(:frame) }
    let(:maker) { described_class.new(frame) }

    it "creates turn for frame" do
      expect {
        maker.make_turn(8)
      }.to change(frame.turns, :count).by(1)
    end

    context "strike" do
      it "closes frame from one turn" do
        maker.make_turn(10)

        expect(frame.turns.count).to eq(1)
        expect(frame.turns.strike.count).to eq(1)
        expect(frame.state).to eq("closed")
      end
    end

    context "spare" do
      it "closes frame" do
        maker.make_turn(8)

        expect(frame.turns.count).to eq(1)
        expect(frame.state).to eq("open")

        maker.make_turn(2)

        expect(frame.turns.count).to eq(2)
        expect(frame.turns.spare.count).to eq(1)
        expect(frame.state).to eq("closed")
      end
    end

    context "none" do
      it "closes frame" do
        maker.make_turn(2)

        expect(frame.turns.count).to eq(1)
        expect(frame.state).to eq("open")

        maker.make_turn(2)
        expect(frame.state).to eq("closed")
      end
    end

    context "frame is closed" do
      it "returns error" do
        2.times { maker.make_turn(5) }
        maker.make_turn(5)

        expect(maker.invalid?).to eq(true)
        expect(maker.errors[:base]).to eq(["Frame is closed"])
      end
    end

    context "last frame" do
      before { allow(frame).to receive(:last?).and_return(true) }

      it "gives 3th turn in split" do
        2.times { maker.make_turn(5) }
        expect(frame.state).to eq("open")
        expect(maker.valid?).to eq(true)

        maker.make_turn(3)
        expect(frame.state).to eq("closed")
      end

      it "closes the game" do
        3.times { maker.make_turn(2) }

        expect(frame.game.state).to eq("closed")
      end
    end

    context "game is closed" do
      let(:game) { frame.game }
      before { game.update_attribute(:state, :closed) }

      it "returns error" do
        maker.make_turn(2)

        expect(maker.errors[:base]).to eq(["Game is closed"])
      end
    end
  end
end
