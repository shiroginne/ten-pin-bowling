class TurnMaker
  include ActiveModel::Validations

  validate :is_game_closed, :is_frame_closed, :is_pins_count

  def self.make_turn(frame, pins_count)
    new(frame).make_turn(pins_count)
  end

  def initialize(frame)
    @frame = frame
  end

  def make_turn(pins_count)
    turn = frame.turns.build(pins_count: pins_count)
    @pins_count = turn.pins_count

    if valid? && turn.valid?
      turn.save! && close_game(frame)
    end
  end

  private
    attr_reader :frame, :pins_count

    def is_game_closed
      errors.add(:base, :game_is_closed) && throw(:abort) if frame.game.closed?
    end

    def is_frame_closed
      errors.add(:base, :frame_is_closed) && throw(:abort) if frame.closed?
    end

    def is_pins_count
      if Integer(pins_count) > Frame::MAXIMUM_PINS
        errors.add(:base, :too_much_pins)
        throw(:abort)
      end
    end

    def close_game(frame)
      if frame.last? && frame.closed?
        frame.game.close!
      else
        true
      end
    end
end
