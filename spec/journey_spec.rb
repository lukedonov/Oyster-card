# frozen_string_literal: true

require 'journey'
require 'oyster_card'
describe Journey do
  let(:station) { double :station, zone: 1 }
  let(:journey) { journey = Journey.new(:station) }
  it 'knows if a journey is not complete' do
    :journey
    expect(journey).not_to be_complete
  end

  it 'expects journey to be complete' do
    :journey
    journey.finish(:station)
    expect(journey).to be_complete
  end

  it 'has a penalty fare by default' do
    :journey
    expect(journey.fare).to eq Journey::PENALTY_FARE
  end

  it 'deducts minimum charge if journey is complete' do
    :journey
    journey.finish(:station)
    expect(journey.fare).to eq 1
  end

  it 'initializes with an entry station' do
    :journey
    expect(journey.entry_station).to eq :station
  end
end
