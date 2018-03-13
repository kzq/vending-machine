class Cashier
  def initialize(change_machine:)
    @change_machine = change_machine
  end

  def credit(money: [])
    rejected_coins = []
    money.each do |coin|
      if currency.valid?(coin)
        hopper = find(coin)
        add_money_to_hopper(hopper)
      else
        rejected_coins << coin
      end
    end
    filter_acceptable_coins(money,rejected_coins)
  end

  def debit(amount:)

  end

  private

  def currency
    @change_machine.currency
  end

  def find(hopper_code)
    hoppers.detect { |hopper| hopper.code == hopper_code }
  end

  def hoppers
    @change_machine.hoppers
  end

  def add_money_to_hopper(hopper)
    hopper.quantity+=1
    hopper
  end

  def filter_acceptable_coins(money, rejected_coins)
    money_partition = money.partition { |coin| rejected_coins.include?(coin) }
    {accepted: money_partition[1], rejected: money_partition[0] }
  end
end