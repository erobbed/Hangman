require 'pry'

class Game

  @@words = [
    "alike", "bright", "remember", "box", "ugly", "equal",
    "milk", "roomy", "unlock", "drab", "intend", "profuse",
    "thread", "inject", "cap", "complete", "godly", "divide", "narrow",
    "weight", "robin", "amuse", "man", "low", "tumble"
  ]

  attr_reader :wrong_guesses, :user, :guesses

  def initialize
  	@winning_word = @@words.sample
    self.welcome
  	self.initial_round
    @wrong_guesses = 0
    @alpha = [
      "A", "B", "C", "D", "E", "F", "G",
      "H", "I", "J", "K", "L", "M", "N",
      "O", "P", "Q", "R", "S", "T", "U",
      "V", "W", "X", "Y", "Z"
    ]
    @status = false
  end

  def welcome
    print "WELCOME TO: \n";
    print " _    _ \n";
    print "| |  | |\n";
    print "| |__| | __ _ _ __   __ _ _ __ ___   __ _ _ __\n";
    print "|  __  |/ _` | '_ \\ / _` | '_ ` _ \\ / _` | '_ \\ \n";
    print "| |  | | (_| | | | | (_| | | | | | | (_| | | | |\n";
    print "|_|  |_|\\__,_|_| |_|\\__, |_| |_| |_|\\__,_|_| |_|\n";
    print "                     __/ |\n";
    print "                    |___/\n";

    puts "Please enter your name:"
    name = self.get_user_input
    puts nil
    self.find_and_set_user(name)
    puts "Hey, #{name.capitalize}!"
    puts nil
    self.options
    puts "Guess carefully, your life is on the line..."
    puts nil
  end

  def get_user_input
    gets.chomp
  end

  def guess
    letter = self.get_user_input.downcase
  	if letter == @winning_word
      @blank = letter.split("")
  	elsif @winning_word.include?(letter)
      puts nil
      puts "Nice! Keep going!"
  		self.fill_in(letter)
      @alpha.delete(letter.upcase)
    elsif letter.upcase == "QUIT"
      puts nil
      puts "Okay! Goodbye!"
      @status = true
  	elsif letter.upcase == "HELP"
      self.options
    else
      puts nil
  		puts "Uh-oh! Try again:"
      puts "'#{@blank.join(" ").upcase}'"
      @alpha.delete(letter.upcase)
      puts nil
      puts "Your remaining letter options are:"
      puts "#{@alpha.join(" ")}"
      @wrong_guesses +=1
    end
  end

  def fill_in(letter)
    @winning_word.split("").each_with_index do |l, ind|
      if l == letter
        @blank[ind] = letter
      end
    end
    puts "#{@blank.join(" ").upcase}"
  end

  def over?
    if @blank.join == @winning_word
      puts "You got it! The word was '#{@winning_word.upcase}'!"
      # user.wins += 1
      @user.update_stats(true)
      @status = true
    elsif @wrong_guesses >= 6
      puts "Sorry. You died."
      puts "The correct word was: '#{@winning_word.upcase}'"
      puts nil
      puts "RIP, #{@user.name}"
      puts nil
      @user.update_stats(false)
      self.lost
      @status = true
    end
  end

  def hangman
    case @wrong_guesses
    when 0
      print " _________     \n";
      print "|         |    \n";
      print "|             \n";
      print "|          \n";
      print "|          \n";
      print "|              \n";
      print "|              \n";
      puts nil
    when 1
      print " _________     \n";
        print "|         |    \n";
        print "|         O    \n";
        print "|             \n";
        print "|             \n";
        print "|              \n";
        print "|              \n";
        puts nil
    when 2
      print " _________     \n";
        print "|         |    \n";
        print "|         O    \n";
        print "|         I  \n";
        print "|             \n";
        print "|              \n";
        print "|              \n";
        puts nil
    when 3
      print " _________     \n";
        print "|         |    \n";
        print "|         O    \n";
        print "|         I\\  \n";
        print "|              \n";
        print "|              \n";
        print "|              \n";
        puts nil
    when 4
      print " _________     \n";
        print "|         |    \n";
        print "|         O    \n";
        print "|        /I\\  \n";
        print "|              \n";
        print "|              \n";
        print "|              \n";
        puts nil
    when 5
      print " _________     \n";
        print "|         |    \n";
        print "|         O    \n";
        print "|        /I\\  \n";
        print "|          \\  \n";
        print "|              \n";
        print "|              \n";
        puts nil
    when 6
  	  print " _________     \n";
      print "|         |    \n";
      print "|         O    \n";
      print "|        /I\\  \n";
      print "|        / \\  \n";
      print "|              \n";
      print "|              \n";
      puts nil
    end
  end

  def runner
    until @status == true
      self.guess
      self.hangman
      self.over?
    end
    self.high_scores
    puts nil
    puts "Would you like to play again? Y/N"
    response = self.get_user_input
    case response.upcase
    when "Y"
      new_game = Game.new
      new_game.runner
    when "N"
      puts nil
      puts "Goodbye!"
    end
  end

  def options
    puts "Please guess a letter or guess the word."
    puts "To exit, please type 'QUIT'."
    puts "To see your options at any time, please type 'HELP'."
  end

  def initial_round
  	self.hangman
    puts nil
    @blank = @winning_word.split("").map {|letter| "_" }
    puts "Guess the word: '#{@blank.join(" ")}'"
  end

  def find_and_set_user(name)
    users = User.all
    @user = users.find(lambda{User.new(name)}) do |user|
      user.name == name
    end
  end

  def lost
    print " ___________.._______\n";
    print "| .__________))______|\n";
    print "| | / /      ||\n";
    print "| |/ /       ||\n";
    print "| | /        ||.-''.\n";
    print "| |/         |/  _  \\\n";
    print "| |          ||  `/,|\n";
    print "| |          (\\`_.'\n";
    print "| |         .-`--'.\n";
    print "| |        /Y . . Y\\ \n";
    print "| |       // |   | \\\\ \n";
    print "| |      //  | . |  \\\\ \n";
    print "| |     ')   |   |   (`\n";
    print "| |          ||'||\n";
    print "| |          || ||\n";
    print "| |          || ||\n";
    print "| |          || ||\n";
    print "| |         / | | \\ \n";
    print "**********l_`-' `-' |****|\n";

  end

  def high_scores
    User.display_stats
  end
end
