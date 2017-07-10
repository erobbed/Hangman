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
    @guesses = []
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
    @user = User.new(name) #leaving this to you to try out, Luke!
    puts "Hey, #{name.capitalize}! Guess carefully, your life is on the line..."
  end

  def get_user_input
    gets.chomp
  end

  def guess
    letter = self.get_user_input.downcase
  	if letter == @winning_word
      @blank = letter.split("")
  	elsif @winning_word.include?(letter)
  		self.fill_in(letter)
    elsif letter.upcase == "QUIT"
      "Okay! Goodbye!"
      @status = true
  	else
  		puts "Uh-oh! Try again:"
      puts "'#{@blank.join.upcase}'"
      @guesses << letter
      self.guesses
      @wrong_guesses +=1
    end
  end

  def fill_in(letter)
    @winning_word.split("").each_with_index do |l, ind|
      if l == letter
        @blank[ind] = letter
        puts "#{@blank.join.upcase}"
      end
    end
  end

  def over?
    if @blank.join == @winning_word
      puts "You got it! The word was '#{@winning_word.upcase}'!!!"
      # user.wins += 1
      @status = true
    elsif @wrong_guesses >= 6
      puts "Sorry. You died."
      puts "The correct word was: '#{@winning_word.upcase}'"
      puts "RIP"
      # user.losses += 1
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
    when 1
      print " _________     \n";
        print "|         |    \n";
        print "|         0    \n";
        print "|             \n";
        print "|             \n";
        print "|              \n";
        print "|              \n";
    when 2
      print " _________     \n";
        print "|         |    \n";
        print "|         0    \n";
        print "|         H  \n";
        print "|             \n";
        print "|              \n";
        print "|              \n";
    when 3
      print " _________     \n";
        print "|         |    \n";
        print "|         0    \n";
        print "|         H\\  \n";
        print "|              \n";
        print "|              \n";
        print "|              \n";
    when 4
      print " _________     \n";
        print "|         |    \n";
        print "|         0    \n";
        print "|        /H\\  \n";
        print "|              \n";
        print "|              \n";
        print "|              \n";
    when 5
      print " _________     \n";
        print "|         |    \n";
        print "|         0    \n";
        print "|        /H\\  \n";
        print "|          \\  \n";
        print "|              \n";
        print "|              \n";
    when 6
  	  print " _________     \n";
      print "|         |    \n";
      print "|         0    \n";
      print "|        /H\\  \n";
      print "|        / \\  \n";
      print "|              \n";
      print "|              \n";

    end
  end

  def runner
    until @status == true
      self.guess
      self.hangman
      self.over?
    end
    puts "Would you like to play again? Y/N"
    response = self.get_user_input
    case response.upcase
    when "Y"
      new_game = Game.new
      new_game.runner
    when "N"
      puts "Goodbye!"
    end
  end

  def initial_round
  	self.hangman
    @blank = @winning_word.split("").map {|letter| "_" }
    puts "Guess the word: '#{@blank.join}'"
  end
end
