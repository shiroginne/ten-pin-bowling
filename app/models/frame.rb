class Frame < ApplicationRecord
  MAXIMUM_PINS = 10

  belongs_to :game, inverse_of: :frames
  belongs_to :player
  has_many :turns, dependent: :destroy

  enum state: [:open, :closed]

  def pins_count
    turns.sum(:pins_count)
  end

  def last?
    game.frames.count == 10
  end

  def close!
    update_attribute(:state, :closed)
  end
end
