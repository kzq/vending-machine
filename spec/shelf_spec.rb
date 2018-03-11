# frozen_string_literal: true

RSpec.describe Shelf do
  let(:shelf) { Shelf.new }
  let(:product) { { 'Snacks': '50p', quantity: 10 } }
  let(:item) { { name: 'Snacks', price: '50p' } }

  describe '#fill' do
    it 'fills the shelf with items' do
      allow(Item).to receive(:new).with(:Snacks, '50p').and_return(item)
      shelf.fill(product)
      expect(shelf.quantity).to eq(10)
      expect(shelf.item).to eq(item)
    end
  end

  it 'responds to code' do
    expect(shelf).to respond_to(:code)
  end

  it 'responds to quantity' do
    expect(shelf).to respond_to(:quantity)
  end

  it 'responds to item' do
    expect(shelf).to respond_to(:item)
  end

  describe '#add_item' do
    it 'add an item to shelf' do
      shelf.add_item
      expect(shelf.quantity).to eq(1)
    end
  end

  describe '#remove_item' do
    it 'removes an item from the shelf' do
      shelf.remove_item
      expect(shelf.quantity).to eq(0)
    end
  end
end
