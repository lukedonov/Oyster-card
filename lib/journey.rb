# frozen_string_literal: true

require_relative 'oyster_card'
class Journey
  attr_reader :entry_station, :exit_station
  PENALTY_FARE = 6
  def initialize(station)
    @entry_station = station
    @exit_station
  end

  def finish(station)
    @exit_station = station
  end

  def complete?
    @exit_station
  end

  def fare
    !complete? ? PENALTY_FARE : 1
  end
end
