class OysterCard
  attr_reader :balance, :fare

  def initialize
    @balance = 50
    @fare = fare
  end

  def check_balance
    @balance
  end

  def top_up(num)
    fail "Over top-up limit" if over_limit?(num)
    @balance += num
  end

  def tap_out
    @balance -= @fare
  end

  private
  def over_limit?(num)
    @balance + num > 50
  end

end
