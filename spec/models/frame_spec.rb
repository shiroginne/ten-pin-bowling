require 'rails_helper'

RSpec.describe Frame, type: :model do
  describe "#state" do
    let(:frame) { build(:frame) }

    it "open by default" do
      expect(frame.state).to eq("open")
    end
  end
end
