class SecretNumber
  attr_reader :set_of_numbers, :secret_number
  def initialize(set_of_numbers=(1..10))
    @set_of_numbers = set_of_numbers
    @secret_number = [*set_of_numbers].sample
  end

  def to_s
    "#{set_of_numbers.min} and #{set_of_numbers.max}"
  end
end
