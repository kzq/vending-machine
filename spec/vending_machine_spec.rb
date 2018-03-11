# frozen_string_literal: true

RSpec.describe VendingMachine do
  subject(:machine) { described_class.new }

  describe "initialize" do
    let(:shelf_set) { double("ShelfSet") }
    let(:change_machine) { double("ChangeMachine") }

    before :each do
      allow(ShelfSet).to receive(:new).with([]).and_return(shelf_set)
      allow(ChangeMachine).to receive(:new).and_return(change_machine)
    end

    context "when machine is created with empty components" do
      it { is_expected.to have_attributes(shelf_set: shelf_set , change_machine: change_machine) }
    end

    context "when machine is created with pre populated componets" do
      subject { described_class.new(shelf_set: shelf_set , change_machine: change_machine) }

      it { is_expected.to have_attributes(shelf_set: shelf_set , change_machine: change_machine) }
    end
  end

  it "knows about its shelf set" do
    expect(subject).to respond_to(:shelf_set)
  end

  it "knows about its attached cash machine" do
    expect(subject).to respond_to(:change_machine)
  end
end