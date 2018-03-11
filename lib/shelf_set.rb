class ShelfSet
  attr_accessor :shelves

  def initialize(shelves)
    @shelves = shelves
  end

  def add(shelf:)
    @shelves.push(*shelf)
  end

  def find(shelf_code)
    @shelves.detect { |shelf| shelf.code == shelf_code }
  end
end