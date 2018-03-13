class Transaction
  attr_reader :payments, :charge

  def initialize(payments:[], charge:)
    @payments, @charge = payments, charge
  end

  def process(payment:)
    @payments << payment
    status
  end

  def status
    { info: get_status, balance: balance }
  end

  def balance
    round(amount_paid - @charge)
  end

  def amount_paid
    round(@payments.inject(0,:+))
  end

  private

  def get_status
    status_tags[(amount_paid <=> @charge)]
  end

  def status_tags
    { -1=> "remaining", 0=> "complete", 1=> "due" }
  end

  def round(amount)
    amount.round(2)
  end
end