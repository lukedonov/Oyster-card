# frozen_string_literal: true

require 'oyster_card'

describe OysterCard do
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journeys) { [in: entry_station, exit: exit_station] }
  let(:topup) { subject.instance_variable_set(:@balance, 10) }

  it 'returns an empty list of journeys by default' do
    expect(subject.history).to eq []
  end

  it 'checks that touching in and out creates a journey' do
    topup
    subject.tap_in(entry_station)
    subject.tap_out(exit_station)
    expect(subject.history).to eq journeys
  end

  describe '#check_balance' do
    it 'returns the card balance' do
      subject.instance_variable_set(:@balance, 20)
      expect(subject.check_balance).to eq 20
    end
  end

  describe '#top_up' do
    it 'adds money to the oyster card' do
      subject.instance_variable_set(:@balance, 0)
      subject.top_up(10)
      expect(subject.balance).to eq 10
    end

    it 'raises an error when you top up too much' do
      subject.instance_variable_set(:@balance, 90)
      expect { subject.top_up(2) }.to raise_error 'Over top-up limit'
    end
  end

  describe '#tap_out' do
    it 'returns false when card has been tapped out but not in' do
      expect(subject.in_journey?).to eq false
    end

    it 'deducts minimum fare when you tap out' do
      topup
      subject.tap_in(entry_station)
      expect { subject.tap_out(exit_station) }.to change { subject.balance }.by -OysterCard::MIN_CHARGE
    end

    it 'charges penalty fare if tap out twice' do
      topup
      subject.tap_out(exit_station)
      expect { subject.tap_out(exit_station) }.to change { subject.balance }.by -Journey::PENALTY_FARE
    end
  end

  describe '#tap_in' do
    it 'returns true when card has been tapped in but not out' do
      topup
      subject.tap_in(entry_station)
      expect(subject.in_journey?).to eq true
    end

    it 'raises an error when balance is less than £1' do
      subject.instance_variable_set(:@balance, 0)
      expect { subject.tap_in(entry_station) }.to raise_error 'insufficient balance'
    end

    it 'charges penalty fare if tap in twice' do
      topup
      subject.tap_in(entry_station)
      expect { subject.tap_in(entry_station) }.to change { subject.balance }.by -Journey::PENALTY_FARE
    end
  end
end
