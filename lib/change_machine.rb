class ChangeMachine
  attr_accessor :hoppers
  attr_reader :currency

  HOPPER_CAPACITY = 25
  def load_cash(currency: GBP)
    @currency = currency
    @hoppers = money.collect do |coin|
      hopper(coin: coin,quantity: HOPPER_CAPACITY)
    end
  end

  private

  def money
    @currency.money
  end

  def hopper(coin:, quantity:)
    Hopper.new(coin,quantity)
  end
end

class InvalidMoney < StandardError; end

#coin container
Hopper = Struct.new(:code, :quantity)