# frozen_string_literal: true

RSpec.describe Installer do
  let(:machine) { double("VendingMachine") }
  let(:shelf_filler) { double("ShelfFiller") }

  before :each do
    allow(VendingMachine).to receive(:new).and_return(machine)
    allow(ShelfFiller).to receive(:new).and_return(shelf_filler)
  end

  describe "initialize" do
    subject(:installer) { described_class.new }

    context "when using default settings" do
      it "sets machine attribute" do
        expect(installer).to have_attributes(machine: machine)
      end
    end
  end

  it "gives access to new machine that is under preparation" do
    expect(subject).to respond_to(:machine)
  end

  describe "#setup" do
    subject(:installer) { described_class.new }
    let(:products) { [{ 'Snacks': '50p' }, { 'Water': '70p', quantity: 15 }] }

    it "returns new machine" do
      allow(shelf_filler).to receive(:fill_all).with(products).and_return("shelves")
      allow(machine).to receive_message_chain("shelf_set.add").with(:shelf=>"shelves")
      allow(machine).to receive_message_chain("change_machine.load_cash").with("GBP")
      installer.setup(products: products)
      expect(installer.machine).to eq(machine)
    end
  end
end