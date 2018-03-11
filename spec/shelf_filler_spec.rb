# frozen_string_literal: true

RSpec.describe ShelfFiller do
  let(:shelf_filler) { described_class.new }
  let(:products) { [{ 'Snacks': '50p' }, { 'Water': '70p', quantity: 15 }] }

  describe '#fill_all' do
    let(:shelf) { double('Shelf') }

    it 'populates shelves with given products' do
      allow(Shelf).to receive(:new).and_return(shelf)
      allow(shelf).to receive(:code=).and_return('001')
      allow(shelf).to receive(:fill).and_return(shelf)
      shelves = shelf_filler.fill_all(products)
      expect(shelves).to be_a(Array)
      expect(shelves.length).to eq(2)
    end
  end
end
