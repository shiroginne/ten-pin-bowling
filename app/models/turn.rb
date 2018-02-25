class Turn < ApplicationRecord
  belongs_to :frame, inverse_of: :turns

  validates :pins_count, numericality: { less_than_or_equal_to: 10, only_integer: true }

  enum scoring: { spare: 1, strike: 2 }

  before_create :assing_scoring

  private
    def assing_scoring
      self.scoring = :spare if (frame.pins_count + pins_count) == 10
      self.scoring = :strike if pins_count == 10
    end
end
