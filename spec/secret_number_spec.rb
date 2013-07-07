require 'minitest/autorun'
require_relative '../lib/secret_number'

describe SecretNumber do
  it "take a range on initialization" do
    secret_number = SecretNumber.new(0..100)
    secret_number.set_of_numbers.min.must_equal 0
    secret_number.set_of_numbers.max.must_equal 100
  end

  it "sets defaults if not passed on on initialization" do
    secret_number = SecretNumber.new
    secret_number.set_of_numbers.min.must_equal 1
    secret_number.set_of_numbers.max.must_equal 10
  end

  it "sets a secret number in the range given" do
    sn1= SecretNumber.new
    (1..10).must_include sn1.secret_number

    sn2= SecretNumber.new(100..110)
    (100..110).must_include sn2.secret_number
  end

  it "picks a random number" do
    result = Hash.new(0)
    10.times do 
      sn = SecretNumber.new(1..2)
      result[sn.secret_number] += sn.secret_number
    end
    result[2].wont_equal 0, "should be random number"
  end

  it "returns a well formatted number for printing" do
    sn = SecretNumber.new(1..2)
    sn.to_s.must_equal "1 and 2"
    "#{sn}".must_equal "1 and 2"
  end
end
