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
        expect(maker.errors.count).to eq(1)
      end
    end
  end
end
