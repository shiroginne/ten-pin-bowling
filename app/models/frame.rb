class Frame < ApplicationRecord
  include Closable

  MAXIMUM_PINS = 10
  TURNS_PER_FRAME = 2

  belongs_to :game, inverse_of: :frames
  belongs_to :player
  has_many :turns, dependent: :destroy

  before_create :validate_maximum_frames

  def pins_count
    turns.sum(:pins_count)
  end

  def turns_per_frame
    return TURNS_PER_FRAME + 1 if last? && (spare? || strike?)
    return TURNS_PER_FRAME - 1 if strike? && !last?
    TURNS_PER_FRAME
  end

  def last?
    game.frames.count == Game::TOTAL_FRAMES
  end

  def spare?
    turns.spare.any?
  end

  def strike?
    turns.strike.any?
  end

  def out_of_turns?
    turns.count >= turns_per_frame
  end

  private
    def validate_maximum_frames
      if game.frames.count >= Game::TOTAL_FRAMES
        errors.add(:base, :too_much_frames)
        throw(:abort)
      end
    end
end
