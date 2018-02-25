class FrameCloser
  def initialize(frame)
    @frame = frame
    @game = frame.game
  end

  def close!
    if @frame.strike? || @frame.out_of_turns?
      @frame.close!
      create_next_frame
    end
  end

  private
    def create_next_frame
      if @game.frames.open.where(player: @frame.player).none?
        @game.frames.create(player: @frame.player)
      end
    end
end
