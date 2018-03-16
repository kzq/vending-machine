class Shelf
  attr_accessor :code, :quantity, :item

  def initialize
    @quantity = 0
  end

  def fill(product)
    product = defaults.merge(product)
    self.tap do |shelf|
      shelf.quantity = product[:quantity]
      item_tuple = extract_item(product)
      shelf.item = Item.new(item_tuple[0], item_tuple[1])
    end
  end

  def add_item
    @quantity += 1
  end

  def remove_item
    @quantity -= 1 unless @quantity <= 0
  end

  def defaults
    { quantity: 20 }
  end

  private

  def extract_item(product)
    product.delete(:quantity)
    product.to_a.flatten
  end
end

# item
Item = Struct.new(:name, :price)
