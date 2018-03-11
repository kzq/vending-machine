# frozen_string_literal: true

RSpec.describe ShelfSet do
  let(:shelf) { double('Shelf') }
  let(:shelf_set) { ShelfSet.new([shelf]) }

  describe 'initialize' do
    subject { shelf_set }
    it { is_expected.to have_attributes(shelves: [shelf]) }
  end

  it 'contains all shelves in the machine' do
    expect(shelf_set).to respond_to(:shelves)
  end

  describe '#add' do
    it 'adds a new shelf into shelf set' do
      shelf_set.add(shelf: shelf)
      expect(shelf_set.shelves).to match_array([shelf, shelf])
    end

    it 'adds multiple shelves into shelf set' do
      shelf_set.add(shelf: [shelf, shelf, shelf])
      expect(shelf_set.shelves).to include(shelf)
      expect(shelf_set.shelves.length).to eq(4)
    end
  end

  describe '#find' do
    it 'locates the give shelf' do
      allow(shelf).to receive(:code).and_return('shelf_code')
      shelf001 = shelf_set.find('shelf_code')
      expect(shelf001).to eq(shelf)
      expect(shelf001.code).to eq('shelf_code')
    end
  end
end
