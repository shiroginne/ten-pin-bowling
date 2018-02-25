class ScoreUpdater
  def self.update_score(frame)
    updater = new(frame)
    updater.update_score!
    updater.update_previous_score!
  end

  attr_reader :frame, :game, :previous_frame

  def initialize(frame)
    @frame = frame
    @game = frame.game
  end

  def update_score!
    score = frame.pins_count
    frame.update_attribute(:score, score)
  end

  def update_previous_score!
    update_previous if previous_need_to_be_updated? && frame.closed?
  end

  private
    def previous_frame
      @previous_frame ||= game.frames.closed.where.not(id: frame.id).last
    end

    def previous_need_to_be_updated?
      previous_frame&.strike? || previous_frame&.spare?
    end

    def update_previous
      if previous_frame.strike?
        previous_frame.score += frame.pins_count
      end

      if previous_frame.spare?
        first_turn = frame.turns.first
        previous_frame.score = previous_frame.pins_count + first_turn.pins_count
      end

      previous_frame.save
    end
end
