class OysterCard
  attr_reader :balance, :fare
  MIN_BALANCE = 1
  MAX_BALANCE = 90

  def initialize
    @balance = 0
    @fare = fare.to_i
    @status = false
  end

  def check_balance
    @balance
  end

  def top_up(num)
    fail "Over top-up limit" if over_limit?(num)
    @balance += num
  end

  def tap_in
    if @balance >= MIN_BALANCE
      @status = true 
    else
      fail "insufficient balance"
    end
  end
  
  def tap_out
    @balance -= @fare
    @status = false
  end

  def in_journey?
    @status
  end

  private
  def deduct
    @balance -= @fare
  end

  def over_limit?(num)
    @balance + num > MAX_BALANCE
  end

end
