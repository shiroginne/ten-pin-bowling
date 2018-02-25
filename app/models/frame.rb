class Frame < ApplicationRecord
  include Closable

  MAXIMUM_PINS = 10

  belongs_to :game, inverse_of: :frames
  belongs_to :player
  has_many :turns, dependent: :destroy

  before_create :validate_maximum_frames
  after_update :create_next_frame, if: -> { closed? && !last? }

  def pins_count
    turns.sum(:pins_count)
  end

  def last?
    game.frames.count == Game::TOTAL_FRAMES
  end

  private
    def validate_maximum_frames
      if game.frames.count >= Game::TOTAL_FRAMES
        errors.add(:base, :too_much_frames)
        throw(:abort)
      end
    end

    def create_next_frame
      game.frames.create(player: player)
    end
end
