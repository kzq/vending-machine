# frozen_string_literal: true

RSpec.describe Transaction do
  subject(:transaction) { described_class.new(charge: 0.60) }

  describe "#initialize" do
    it "sets payment and charge attributes" do
      expect(transaction).to have_attributes(payments: [], charge: 0.60)
    end
  end

  it "provides access to its attributes" do
    expect(transaction).to respond_to(:payments)
    expect(transaction).to respond_to(:charge)
  end

  describe "#process" do
    it "stores chunks of payments" do
      transaction.process(payment: 0.20)
      expect(transaction.payments).to eq([0.20])
    end
  end

  describe "#status" do
    it "sends back upto-date status of on going transaction" do
      transaction.process(payment: 0.10)
      status = transaction.process(payment: 0.20)
      expect(status).to eq({:info=>"remaining", :balance=>-0.30})
    end
  end

  describe "#balance" do
    it "returns transaction balance" do
      transaction.process(payment: 0.50)
      expect(transaction.balance).to eq(-0.10)
    end
  end

  describe "#amount_paid" do
    it "returns total amount paid" do
      transaction.process(payment: 0.50)
      transaction.process(payment: 0.50)
      expect(transaction.amount_paid).to eq(1)
    end
  end
end