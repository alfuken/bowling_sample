class LastFrame < Frame
  def initialize(game)
    super(10, game)
  end
  
  def description
    string = ""
    string << (strike? ? "X" : roll_as_string(first_roll)) + ' '
    string << (spare? ? "/" : (second_strike? ? "X" : roll_as_string(second_roll))) + ' '
    string << (third_strike? ? "X" : roll_as_string(third_roll)) if strike_or_spare?
    string
  end
  
  def finished?
    @rolls.size == (strike_or_spare? ? 3 : 2)
  end

  def score
    return if not finished?
    first_roll + second_roll + (strike_or_spare? ? third_roll : 0)
  end

  def validate
    super
    @errors << "Wrong value for the third ball in game." if third_roll && !third_roll_valid?
  end

  def last_frame?; true; end

  def second_strike?
    strike? && second_roll == 10
  end
  
  def third_strike?
    second_strike? && third_roll == 10
  end
  
  def spare?
    second_roll && !strike? && (first_roll + second_roll == 10)
  end
  
  def second_roll_valid?
    expected_range = spare? ? (first_roll + second_roll) : second_roll
    second_roll && roll_in_range?(expected_range)
  end

  def third_roll_valid?
    third_roll && strike_or_spare? && roll_in_range?(third_roll)
  end
  
end
