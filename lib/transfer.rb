class Transfer

  attr_accessor :status
  attr_reader :sender, :receiver, :amount

  def initialize(sender, receiver, amount = 50)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
  end

  def valid?
    self.sender.valid? && self.sender.balance - amount < 0 && self.receiver.valid?
  end

  def execute_transaction
    if self.valid? && self.status == "pending"
      self.receiver.deposit(amount)
      self.sender.balance -= amount
      self.status = "complete"
    else
      "Transaction rejected. Please check your account balance."
      self.status = "rejected"
    end
  end

  def reverse_transfer
    if self.status == "complete"
      self.receiver.balance -= amount
      self.sender.deposit(amount)
      self.status == "reversed"
    end
  end
end
