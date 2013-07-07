require_relative 'lib/game'
require_relative 'lib/game_runner'
require_relative 'lib/player'
require_relative 'lib/secret_number'

# The first argument is to receive the max number of guesses a Player
# may make.
number_of_guesses = ARGV[0]

# The second and third arguments are to receive the low and high end of
# the range of numbers a Player may pick from.
low_range = ARGV[1]
high_range = ARGV[2]

begin
  # We need to make sure that the input we got makes sense.
  unless number_of_guesses
    raise ArgumentError, "Please enter the max number of guesses a Player may make."
  end

  # We also need both a high and a low number!
  unless low_range && high_range
    raise ArgumentError, "Please make sure to enter both a low and high number for the range of numbers a Player may make guesses from."
  end

  # Make sure the low number is lower than high number!
  unless low_range < high_range
    raise ArgumentError, "Your low range number needs to be less than the high range number."
  end

  loop do
    # Create a new Game based on the command line parameters
    game = Game.new(SecretNumber.new(low_range.to_i..high_range.to_i), number_of_guesses.to_i)
    # Start the Game
    GameRunner.start(game)
    # When the Game ends, ask the Player if they would like to play
    # again.
    puts "\nNice Game! Would you like to play again?"
    puts "(Q)uit or (C)ontinue?"
    # Make sure the Player's input can be accurately compared against
    choice = $stdin.gets.chomp.upcase
    # If they choose "Q" quit the Game gracefully.
    if choice == "Q"
      puts "\nThanks for playing!"
      break
    end
  end

# If the arguments aren't correct, rescue the error and exit the
# program.
rescue ArgumentError => e
  puts e.message
  puts "usage: ruby secret_number_game_completed.rb [number_of_guesses] [low_range_number] [high_range_number]"
end
