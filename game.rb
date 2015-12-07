class Game
  attr_accessor :frames
  
  def initialize()
    @frames ||= [Frame.new(1, self)]
    @error = nil
  end
  
  def roll!(ball)
    @frame = frames.last
    
    if @frame.finished?
      return @error = "Game over. Please, see the score." if game_over?

      @frame = new_frame
      frames << @frame
    end
    
    @frame.roll!(ball)
  end
  
  def new_frame
    next_frame_number == 10 ? LastFrame.new(self) : Frame.new(next_frame_number, self)
  end
  
  def next_frame_number
    frames.size + 1
  end
  
  def total_score
    frames.map{|e| e.score.to_i}.inject(&:+)
  end
  
  def game_over?
    @frame && @frame.finished? && next_frame_number >= 11
  end
  
  def rolls
    frames.map(&:rolls)
  end
end
