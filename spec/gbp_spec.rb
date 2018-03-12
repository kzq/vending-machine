# frozen_string_literal: true

RSpec.describe GBP do
  subject { GBP }

  it "has list of all acceptable coins" do
    expect(GBP.money.to_a).to include("1p", "10p", "20p", "50p", "£1", "£2")
  end

  it "validates the given coin" do
    expect(GBP.valid?("5p")).to be true
    expect(GBP.valid?("90p")).to be false
  end

  it "calculates value of given denominator" do
    expect(GBP.to_value("5p")).to eq(0.05)
  end

  it "matches the value of its denominator" do
    expect(GBP.to_coin(100)).to eq("£1")
  end
end