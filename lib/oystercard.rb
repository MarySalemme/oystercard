class Oystercard
  attr_reader :balance, :status, :minimum_balance
  DEFAULT_BALANCE = 0
  MAX_LIMIT = 90
  MIN_BALANCE = 1

  def initialize(balance = DEFAULT_BALANCE, status = :not_in_use)
    @status = status
    @balance = balance
  end

  def top_up(money)
    raise "Exceeded £#{MAX_LIMIT} limit" if limit_reached?(money)
    @balance += money
  end

  def deduct(money)
    @balance -= money
  end

  def in_journey?
    @status == :in_use
  end

  def touch_in
    raise "Card does not have the #{MIN_BALANCE} minimum balance, must top up first" unless has_min_balance?
    @status = :in_use
  end

  def touch_out
    @status = :not_in_use
  end

private

  def limit_reached?(money)
    @balance + money > MAX_LIMIT
  end

  def has_min_balance?
    @balance >= MIN_BALANCE
  end
end
