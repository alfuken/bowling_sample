class Frame
  attr_reader :errors, :rolls

  def initialize(number, game)
    @frame_number = number
    @errors = []
    @rolls = []
    @game = game
  end
  
  def roll!(ball)
    @rolls << ball.to_i
    validate
    @rolls.pop if invalid?
    valid?
  end
  
  def description
    if strike?
      "X"
    elsif spare?
      "#{roll_as_string(first_roll)} /"
    else
      "#{roll_as_string(first_roll)} #{roll_as_string(second_roll)}"
    end
  end
  
  def roll_as_string(roll)
    roll == 0 ? "-" : roll.to_s
  end
  
  def score
    return if not finished?
    if strike?
      10 + two_followup_rolls if two_followup_rolls
    elsif spare?
      10 + first_followup_roll if first_followup_roll
    else
      first_roll + second_roll
    end
  end
  
  def finished?
    strike? || @rolls.size == 2
  end
  
  def strike_or_spare?
    strike? || spare?
  end
  
  def next_frame
    @game.frames[@frame_number]
  end
  
  def over_next_frame
    @game.frames[@frame_number + 1]
  end
  
  def first_followup_roll
    return unless next_frame
    next_frame.first_roll
  end

  def second_followup_roll
    return unless next_frame
    # should we take a second roll of the first next frame?
    if !next_frame.strike? || next_frame.last_frame?
      # it is not a strike || its a last frame, we can take it's second roll
      next_frame.second_roll if next_frame
    else
      # otherwise, it's a strike and we must wait for the one more frame to take the roll from
      over_next_frame.first_roll if over_next_frame
    end
  end
  
  def two_followup_rolls
    first_followup_roll + second_followup_roll if first_followup_roll && second_followup_roll
  end

  def validate
    @errors.clear
    @errors << "Frame number is invalid. Something went wrong." unless frame_number_valid?
    @errors << "Wrong value for the first ball in game."  if !first_roll_valid?
    @errors << "Wrong value for the second ball in game." if second_roll && !second_roll_valid?
    @errors << "Wrong value for the third ball in game."  if third_roll && !third_roll_valid?
  end
  
  def valid?
    @errors.empty?
  end
  
  def invalid?
    !valid?
  end
  
  def last_frame?; false; end
  alias_method :last?, :last_frame?
  
  def first_roll;  @rolls[0]; end
  def second_roll; @rolls[1]; end
  def third_roll;  @rolls[2]; end
  
  def strike?
    first_roll == 10
  end
  
  def second_strike?
    false
  end
  
  def third_strike?
    false
  end
  
  def spare?
    second_roll && !strike? && (first_roll + second_roll == 10)
  end
    
  def frame_number_valid?
    @frame_number.to_i > 0 && @frame_number.to_i <= 10
  end
  
  def first_roll_valid?
    roll_in_range?(first_roll)
  end
  
  def second_roll_valid?
    second_roll && !strike? && roll_in_range?(first_roll + second_roll)
  end

  def third_roll_valid?
    third_roll.nil?
  end
  
  def roll_in_range?(roll)
    (0..10) === roll
  end
  
end
