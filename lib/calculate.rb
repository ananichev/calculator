class Calculate

  attr_accessor :currency, :operation, :result

  def initialize(currency, operation)
    @currency = currency
    @operation = operation
  end

  def get_result(sale, purchase, amount)
    grn_rate = self.operation == 'buy' ? purchase : sale
    rub_rate = self.operation == 'buy' ? sale : purchase
    self.result = self.currency == 'grn' ? (amount * grn_rate) : (amount / rub_rate)
  end

  def format
    "#{self.result.round(3)} #{self.currency == 'grn' ? 'рублей' : 'гривен'}"
  end
end