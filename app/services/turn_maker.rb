class TurnMaker
  def initialize(frame, pins_count: 0)
    @frame = frame
    @pins_count = pins_count
  end

  def save
    @frame.turns.create(pins_count: @pins_count)
  end
end
