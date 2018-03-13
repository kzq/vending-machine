# TODO Encapsulate shelf behaviour into Shelfing module
# TODO Create Currency interface for all currency types
# TODO Create mixin module for helper methods
# OPTIMIZE imporive exception managemnt
# OPTIMIZE improve interactor


require './lib/vending_machine'



products = [{ 'pepsi': '50p', quantity: 10 }, { 'chocolate': '70p' }, {'coca-cola': '60p'}, { 'gum': '10p' }]
# using stand alone Installer

# installer = Installer.new
# machine = installer.setup(products: products)

puts "\n\n"
puts "Setting up your vending machine with the follwoing products\n\n"
puts "Product =#{products}\n\n"

machine = VendingMachine.new

# setup machine
machine.setup(products: products)

# shelf_set
shelf_set = machine.shelf_set

# change_machine
change_machine = machine.change_machine

puts "Current Stock in hand ......................\n\n"
puts "#{ shelf_set.shelves.collect { |shelf| { name: shelf.item.name, quantity: shelf.quantity } } }"
puts "\n\n"

# product selection codes
shelf_codes = machine.shelf_set.shelves.map(&:code)

puts "SELECTION (please select one code) = #{shelf_codes}\n\n"
selection = gets.chomp
puts "\n\n"

shelf = machine.shelf_set.find(selection.to_i)
product = shelf.item.name

product_price = shelf.item.price
puts "Selected product price is = #{product_price}\n\n"

puts "Please insert or pay = #{product_price}\n\n"

price = GBP.to_value(product_price)

transaction = Transaction.new(charge: price)

while(transaction.status[:info] == "remaining")
  coin = gets.chomp
  if GBP.valid?(coin)
    transaction.process(payment: GBP.to_value(coin))
    puts "Total amount_paid = #{GBP.to_coin(transaction.amount_paid)}\n\n"
  else
    puts "Invalid coin returned = #{coin}\n\n"
  end
end

shelf.remove_item
puts "Here is your product = #{product}\n\n"

puts "PAYMENT DETAILS............\n\n"
puts "Total payments = #{transaction.payments}"
puts "Total amount paid = #{transaction.amount_paid}"
puts "Total balance = #{transaction.balance}"
puts "Total status = #{transaction.status}\n\n"

puts "Current Stock in hand......................\n\n"
puts "#{ shelf_set.shelves.collect { |shelf| { name: shelf.item.name, quantity: shelf.quantity } } }"
puts "\n\n"

puts "Adding money to cash box..."

coins = transaction.payments.collect {|coin_value| GBP.to_coin(coin_value) }

cashier = Cashier.new(change_machine: change_machine)
credited = cashier.credit(money: coins)

puts "Amount credited = #{credited}\n\n"

