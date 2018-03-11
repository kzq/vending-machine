class VendingMachine
  attr_reader :shelf_set, :change_machine

  def initialize(shelf_set: ShelfSet.new([]), change_machine: ChangeMachine.new)
    @shelf_set, @change_machine = shelf_set, change_machine
  end
end

require 'shelf_set'
require 'change_machine'
require 'installer'
require 'shelf_filler'
require 'shelf'