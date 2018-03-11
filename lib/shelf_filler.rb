class ShelfFiller
  def fill_all(products)
    shelves = []
    products.each_with_index do |product, shelf_number|
      shelf = prepare_shelf(shelf: Shelf.new, shelf_code: shelf_number, item: product)
      shelves << shelf
    end
    shelves
   end

  private

  def prepare_shelf(shelf:, shelf_code:, item:)
    shelf.code = shelf_code
    shelf.fill(item)
  end
end
