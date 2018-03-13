require 'set'
class GBP
  @@coins = Set['1p', '2p', '5p', '10p', '20p', '50p', '£1', '£2']

  class << self
   def money
     @@coins
   end

   def valid?(coin)
     Set[coin].subset? money
   end

   def to_value(coin)
     remove_characters(coin).to_i * units[remove_numbers(coin).to_sym]
   end

   def to_coin(value)
    (value >= units[:p] && value < 1) ? "#{ '%.0f' % (value * units[:£]) }p" : "£#{ value/units[:£] }"
   end

   def units
     { p: 0.01, £: 100}
   end
 end
end

def remove_characters(str)
  str.gsub(/\D/, "")
end

def remove_numbers(str)
  str.gsub(/(\d)/, "")
end