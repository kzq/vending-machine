class VendingMachine
  attr_reader :shelf_set, :change_machine

  def initialize(shelf_set: ShelfSet.new([]), change_machine: ChangeMachine.new)
    @shelf_set = shelf_set
    @change_machine = change_machine
  end

  def setup(products: [] , installer: Installer.new(machine: self))
    installer.setup(products: products)
  end
end

require_relative 'shelf_set'
require_relative 'change_machine'
require_relative 'installer'
require_relative 'shelf_filler'
require_relative 'shelf'
require_relative 'gbp'
require_relative 'cashier'
require_relative 'transaction'
require 'pry'