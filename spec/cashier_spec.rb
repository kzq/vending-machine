# frozen_string_literal: true

RSpec.describe Cashier do
  let(:change_machine) { double("ChangeMachine") }
  let(:currency) { double("GBP") }
  let(:hoppers) { [double("Hopper")] }
  let(:hopper) { double("Hopper") }
  subject(:cashier) { Cashier.new(change_machine: change_machine) }

  before :each do
    allow(change_machine).to receive(:currency).and_return(currency)
    allow(change_machine).to receive(:hoppers).and_return(hoppers)
    allow(hoppers).to receive(:detect).and_return(hopper)
    allow(hopper).to receive(:quantity=).and_return(6)
    allow(hopper).to receive(:quantity).and_return(5)
  end

  describe "#insert_money" do
    it "inserts money into correct coin slot" do
      allow(currency).to receive(:valid?).and_return(true)
      expect(cashier.insert_money("5p")).to eq(hopper)
    end

    it "shouts when invalid money is given" do
      allow(currency).to receive(:valid?).and_return(false)
      expect { cashier.insert_money("115p") }.to raise_error(InvalidMoney, "Invalid money")
    end
  end

  describe "#find" do
    it "searches hoppers to get correct one" do
      expect(cashier.find("1p")).to eq(hopper)
    end
  end
end