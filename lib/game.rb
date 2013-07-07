require_relative 'player'
class Game
  attr_reader :guesses_allowed, :guesses_left, :status, :message, :secret_number
  def initialize(secret_number, guesses_allowed = 3)
    @secret_number = secret_number
    @guesses_allowed = guesses_allowed
    @guesses_left = guesses_allowed
    @status = :playing
  end

  def make_guess_of(guess)
    return unless playable?
    @guesses_left -= 1
    @current_guess = guess
    set_game_status
    set_message
  end

  def playable?
    ![:win, :lost].include?(@status)
  end


  def correct_guess?
    @current_guess == @secret_number.secret_number
  end

  def player
    @player ||= Player.new
  end

  private 
  def set_game_status
    if correct_guess?
      @status = :won
    elsif guesses_left.zero?
      @status = :lost
    elsif @current_guess > @secret_number.secret_number
      @status = :high
    else
      @status = :low
    end
  end

  def set_message
    @message = 
      {
      high: "Your guess was too high!",
      low: "Your guess was too low!",
      won: "You won! You guessed in #{current_guess_count} turns!",
      lost: "You lost!\nThe secret number was #{@secret_number.secret_number}!"
    }[@status]
  end

  private 
  def current_guess_count
    guesses_allowed -  guesses_left
  end
end
