class Cashier

  def initialize(change_machine:)
    @change_machine = change_machine
  end

  def insert_money(coin)
   if currency.valid?(coin)
    hopper = find(coin)
    add_money_to_hopper(hopper)
   else
     raise InvalidMoney, "Invalid money"
   end
  end

  def currency
    @change_machine.currency
  end

  def find(hopper_code)
    hoppers.detect { |hopper| hopper.code == hopper_code }
  end

  def hoppers
    @change_machine.hoppers
  end

  def transaction(payment:, charge:)
   amount = (payment - charge).round(2)
   status = case amount
   when amount.positive? then  [ :chnage_due, @currency.to_coin(amount) ]
     when amount.negative? then [ :remaining, @currency.to_coin(amount*-1) ]
     else [ :complete, 0 ]
   end
  end

  def total_cash

  end

  def return_change

  end

  def rejected_coins

  end

  private

  def add_money_to_hopper(hopper)
    hopper.quantity+=1
    hopper
  end
end