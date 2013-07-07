require 'minitest/autorun'
require_relative '../lib/game'

class FakeSecretNumber
  # This class will be used to stand in for our secret number class
  # We want to use this instead of our SecretNumber class since we'd be tasked
  # with managing randomness. Here we can have force #secret_number to return 
  # something we know.

  def secret_number
    #hard code the correct answer to be 1
    1
  end
end
describe Game do

  before do
    @secret_number = FakeSecretNumber.new
  end

  it "takes a number of guesses and secret number object on initialization" do
    game = Game.new(@secret_number,1)
    game.guesses_allowed.must_equal 1
  end
  
  it "sets the default number of guesses to 3 of none given" do
    game = Game.new(@secret_number)
    game.guesses_allowed.must_equal 3
  end

  it "returns the secret number object" do
    game = Game.new(@secret_number)
    game.secret_number.secret_number.must_equal 1
  end

  it "collects guess attempt and decriments guess count" do 
    game = Game.new(@secret_number)
    game.guesses_left.must_equal 3

    game.make_guess_of(2)
    game.correct_guess?.must_equal false
    game.guesses_left.must_equal 2

    # This is where our fake comes in. This code should check the objects #secret_number
    # and do a comparison
    game.make_guess_of(1)
    game.correct_guess?.must_equal true
    game.guesses_left.must_equal 1
  end

  it "sets the player's name" do 
    game = Game.new(@secret_number)
    game.player.name = "Steven Nunez"
    game.player.name.must_equal "Steven Nunez"
  end

  it "gives feedback on guess proximity" do
    game = Game.new(@secret_number)
    game.make_guess_of(2)
    game.message.must_equal "Your guess was too high!"
    game.status.must_equal :high

    game.make_guess_of(0)
    game.message.must_equal "Your guess was too low!"
    game.status.must_equal :low

    game.make_guess_of(1)
    game.message.must_equal "You won! You guessed in 3 turns!"
    game.status.must_equal :won
  end

  it "returns game's current status" do
    game = Game.new(@secret_number, 1)
    game.status.must_equal :playing
    game.playable?.must_equal true
    game.make_guess_of(42)
    game.status.must_equal :lost
    game.playable?.must_equal false
  end

  it "prevents future guesses if out of guesses" do
    game = Game.new(@secret_number, 1)
    game.make_guess_of(42)
    game.guesses_left.must_equal 0
    game.message.must_equal "You lost!\nThe secret number was 1!"
    game.status.must_equal :lost
    
    game.make_guess_of(1)
    game.message.must_equal "You lost!\nThe secret number was 1!"
    game.status.must_equal :lost
    game.message.must_equal "You lost!\nThe secret number was 1!"
    game.status.must_equal :lost
    
    game.guesses_left.must_equal 0
  end
end
