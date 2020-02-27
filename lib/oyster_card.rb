# frozen_string_literal: true

require_relative 'journey'
class OysterCard
  attr_reader :balance, :fare, :history, :journey
  MIN_BALANCE = 1
  MAX_BALANCE = 90
  MIN_CHARGE = 1

  def initialize
    @balance = 0
    @min_charge = MIN_CHARGE
    @history = []
    @journey = nil
  end

  def check_balance
    @balance
  end

  def top_up(num)
    raise 'Over top-up limit' if over_limit?(num)
    @balance += num
  end

  def tap_in(station)
    raise 'insufficient balance' if balance < MIN_BALANCE
    deduct(Journey::PENALTY_FARE) if @journey
    @journey = Journey.new(station)
  end

  def tap_out(station)
    deduct(Journey::PENALTY_FARE) unless @journey
    if @journey
      @journey.finish(station)
      deduct(@journey.fare)
      push_history
    end
    @journey = nil
  end

  def in_journey?
    !!@journey
  end

  private

  def push_history
    @history << { in: @journey.entry_station, exit: @journey.exit_station }
  end

  def deduct(fare)
    @balance -= fare
  end

  def over_limit?(num)
    @balance + num > MAX_BALANCE
  end
end
