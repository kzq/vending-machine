# frozen_string_literal: true

RSpec.describe ChangeMachine do
  let(:change_machine) { ChangeMachine.new }

  it "reponds to hoppers" do
    expect(change_machine).to respond_to(:hoppers)
  end

  it "reponds to currency" do
    expect(change_machine).to respond_to(:currency)
  end

  describe "#load_cash" do
    let(:hoppers) { [double("Hopper")] }
    USD = Struct.new(:usd) do def self.money; end end

    before :each do
      allow(USD).to receive_message_chain("money.collect").and_return(hoppers)
      change_machine.load_cash(currency: USD)
    end

    it "uses the given currency" do
      expect(change_machine.currency).to eq(USD)
    end

    it "fills all hoppers in change machine" do
      expect(change_machine.hoppers).to be_a(Array)
      expect(change_machine.hoppers).to match_array(hoppers)
    end
  end
end
