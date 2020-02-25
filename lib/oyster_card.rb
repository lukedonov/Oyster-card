class OysterCard
  attr_reader :balance, :fare, :entry_station
  MIN_BALANCE = 1
  MAX_BALANCE = 90
  MIN_CHARGE = 1

  def initialize
    @balance = 0
    @fare = fare.to_i
    @status = false
    @min_charge = MIN_CHARGE
    @entry_station
  end

  def check_balance
    @balance
  end

  def top_up(num)
    fail "Over top-up limit" if over_limit?(num)
    @balance += num
  end

  def tap_in(station)
      fail "insufficient balance" if balance < MIN_BALANCE
      @status = true
  end
  
  def tap_out
    deduct(MIN_CHARGE)
    @entry_station = nil
  end

  def in_journey?
    !!entry_station
  end

  private
  def deduct(fare)
    @balance -= fare
  end

  def over_limit?(num)
    @balance + num > MAX_BALANCE
  end

end
