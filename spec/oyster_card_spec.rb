require 'oyster_card'

describe OysterCard do
  # it { is_expected.to respond_to :check_balance }
  # it { is_expected.to respond_to :tap_in }   
  # it { is_expected.to respond_to :tap_out }   
  # it { is_expected.to respond_to :in_journey? }   
  # it { is_expected.to respond_to(:top_up).with(1).argument }
  
  describe "#check_balance" do
    it "returns the card balance" do 
      subject.instance_variable_set(:@balance, 20)
      expect(subject.check_balance).to eq 20
    end
  end

  describe "#top_up" do
    it "adds money to the oyster card" do
      subject.instance_variable_set(:@balance, 0)
      subject.top_up(10)
      expect(subject.balance).to eq 10
    end

    it "raises an error when you top up too much" do
      subject.instance_variable_set(:@balance, 90)
      expect { subject.top_up(2) }.to raise_error "Over top-up limit" 
    end
  end

  describe "#tap_out" do
    it "returns false when card has been tapped in but not out" do
      subject.tap_out
      expect(subject.in_journey?).to eq false
    end

    it "deducts the fare from the users balance" do
      subject.instance_variable_set(:@fare, 5)
      subject.instance_variable_set(:@balance, 10)
      subject.tap_out
      expect(subject.balance).to eq 5
    end
  end

  describe "#tap_in" do
    it "returns true when card has been tapped in but not out" do
      subject.instance_variable_set(:@balance, 5)
      subject.tap_in
      expect(subject.in_journey?).to eq true
    end

    it "raises an error when balance is less than £1" do
      subject.instance_variable_set(:@balance, 0)
      expect { subject.tap_in }.to raise_error "insufficient balance"
    end
  end
end