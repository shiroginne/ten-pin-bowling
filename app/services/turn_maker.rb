class TurnMaker
  include ActiveModel::Validations

  attr_reader :frame, :pins_count

  validate :validate_frame_closed, :validate_pins_count

  def initialize(frame)
    @frame = frame
  end

  def make_turn(pins_count)
    turn = frame.turns.build(pins_count: pins_count)
    @pins_count = turn.pins_count

    if valid? && turn.valid?
      turn.save && close_frame(frame)
    end
  end

  private
    def validate_frame_closed
      if frame.closed?
        errors.add(:base, :frame_is_closed)
        throw(:abort)
      end
    end

    def validate_pins_count
      if Integer(pins_count) + frame.pins_count > Frame::MAXIMUM_PINS
        errors.add(:base, :too_much_pins)
        throw(:abort)
      end
    end

    def close_frame(frame)
      if is_strike?(frame) || is_spare?(frame) || is_out_of_turns?(frame)
        frame.close!
      else
        true
      end
    end

    def is_strike?(frame)
      frame.turns.strike.any?
    end

    def is_spare?(frame)
      !frame.last? && frame.turns.count >= 2
    end

    def is_out_of_turns?(frame)
      frame.last? && frame.turns.count >= 3
    end
end
