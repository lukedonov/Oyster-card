require 'stations'

describe Station do 
  it "knows it's own name" do
    expect(subject.name).to eq "Liverpool Street"
  end

  it "knows it's own zone" do
    expect(subject.zone).to eq "1"
  end

end