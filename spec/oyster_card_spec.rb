require 'oyster_card'

describe OysterCard do
    it { is_expected.to respond_to :check_balance }
end