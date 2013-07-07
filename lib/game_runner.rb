class GameRunner
  def self.start(game)
    puts "\nWelcome to the Secret Number Game!"
    show_creator
    loop do
      puts "\nWhat is your name?"
      game.player.name = $stdin.gets.chomp
      if game.player.name.empty?
        puts "Name can not be empty"
        redo
      end
      puts "Hi, #{game.player.name}! You have #{game.guesses_allowed} guesses to guess the Secret Number between #{game.secret_number.set_of_numbers}"

      while game.playable?
        puts "\nYou have #{ game.guesses_left } guesses left!"
        puts "Please make your guess:"
        game.make_guess_of($stdin.gets.chomp.to_i)
        puts game.message
      end
    end
  end

  def self.show_creator
    # give yourself some credit!
    puts "Created by Steven Nunez"
  end
end
