class Installer
  attr_reader :machine

  def initialize(machine: VendingMachine.new, shelf_filler: ShelfFiller.new)
    @machine , @shelf_filler = machine, shelf_filler
  end

  def setup(args)
    args = defaults.merge(args)
    products, currency = args[:products], args[:currency]
    fill_shelves(products: products, shelf_filler: @shelf_filler)
    fill_cash_box(currency)
    @machine
  end

  def defaults
    { products: [], currency: "GBP"  }
  end

  private
  def fill_shelves(products:, shelf_filler:)
    shelves = shelf_filler.fill_all(products)
    @machine.shelf_set.add(shelf: shelves)
  end

  def fill_cash_box(currency)
    @machine.change_machine.load_cash(currency)
  end
end