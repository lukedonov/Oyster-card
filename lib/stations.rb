# frozen_string_literal: true

class Station
  attr_reader :zone, :name

  def initialize
    @name = 'Liverpool Street'
    @zone = 1
  end
end
