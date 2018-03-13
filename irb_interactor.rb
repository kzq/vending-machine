# TODO Encapsulate shelf behaviour into Shelfing module
# TODO Create Currency interface for all currency types
# TODO Fix transaction logic
# TODO Create mixin module for helper methods
# OPTIMIZE imporive exception managemnt
# OPTIMIZE improve interactor


require './lib/vending_machine'


products = [{ 'pepsi': '50p', quantity: 10 }, { 'chocolate': '70p' }, {'coca-cola': '60p'}, { 'gum': '10p' }]
# using stand alone Installer

# installer = Installer.new
# machine = installer.setup(products: products)

machine = VendingMachine.new

# setup machine
machine.setup(products: products)

# shelf_set
shelf_set = machine.shelf_set

# change_machine
change_machine = machine.change_machine

# product selection codes
#puts ">>>>>>>>>>>>>>>machine.shelf_set.shelves=#{machine.shelf_set.shelves.inspect}"
shelf_codes = machine.shelf_set.shelves.map(&:code)
puts "Product codes (please select one code) = #{shelf_codes}"
selection = gets.chomp
shelf = machine.shelf_set.find(selection.to_i)

product = shelf.item.name
puts "selected product = #{product}"

product_price = shelf.item.price
puts "selected product price = #{product_price}"

puts "Please insert/p #{product_price}"
coin = gets.chomp

#puts "value of price = #{GBP.to_value(product_price)}"
puts "Received = #{coin}"
puts "value of payment = #{GBP.to_value("#{coin}")}"

cashier = Cashier.new(change_machine: change_machine)
transaction_status = cashier.transaction(payment: GBP.to_value("#{coin}") , charge: GBP.to_value(product_price))
puts "transaction_status = #{transaction_status}"
#hopper = machine.change_machine.insert_money("20p")
#puts "Selected hopper = #{hopper.inspect}"

puts ">>>>>>CASH====="

#cash = machine.change_machine.hoppers
#puts "cash = #{cash.inspect}"
