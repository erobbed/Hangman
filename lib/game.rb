class Game
  include ASCII
  include Categories

  attr_reader :user, :guesses, :category
  attr_accessor :wrong_guesses, :status, :alpha

  def initialize
    self.welcome
    self.wrong_guesses = 0
    self.alpha = ("A".."Z").to_a
  	self.initial_round
    self.status = false
  end

  def blank
    @blank.join(" ").upcase
  end

  def welcome
    logo
    puts "Please enter your name:"
    name = self.get_user_input
    puts nil
    self.find_and_set_user(name)
    puts "Hey, #{name.capitalize}!"
    puts nil
    self.options
    puts nil
    self.choose_category
    puts nil
    puts "Guess carefully, #{name.capitalize}. Your life is on the line..."
    puts nil
  end

  def get_user_input
    gets.chomp
  end

  def display_letters
    puts "#{@alpha.join(" ")}"
  end

  def choose_difficulty
    puts "Choose difficulty: EASY / HARD"
    difficulty = self.get_user_input.upcase
  end

  def choose_category
    if self.choose_difficulty == "HARD"
      puts nil
      puts "Categories:"
      @@hard_categories.each {|category| puts category}
      puts nil
    else
      puts nil
      puts "Categories:"
      @@easy_categories.each {|category| puts category}
      puts nil
    end
    puts "Choose a category:"
    @winning_word = self.send(self.get_user_input.downcase).sample
  end

  def guess
    letter = self.get_user_input.downcase
  	if letter == @winning_word
      @blank = letter.split("")
  	elsif @winning_word.include?(letter)
      self.right_answer(letter)
    elsif letter.upcase == "QUIT"
      puts nil
      puts "Okay! Goodbye!"
      self.status = true
  	elsif letter.upcase == "HELP"
      self.options
    else
      self.wrong_answer(letter)
    end
  end

  def right_answer(letter)
    puts nil
    puts "Nice! Keep going!"
    self.fill_in(letter)
    @alpha.delete(letter.upcase)
    puts nil
    puts "Your remaining letter options are:"
    self.display_letters
  end

  def wrong_answer(letter)
    puts nil
    puts "Uh-oh! Try again:"
    puts "'#{self.blank}'"
    @alpha.delete(letter.upcase)
    puts nil
    puts "Your remaining letter options are:"
    self.display_letters
    self.wrong_guesses +=1
  end

  def fill_in(letter)
    @winning_word.split("").each_with_index do |l, ind|
      if l == letter
        @blank[ind] = letter
      end
    end
    puts "#{self.blank}"
  end

  def over?
    if @blank.join == @winning_word
      puts "You got it! The word was '#{@winning_word.upcase}'!"
      # user.wins += 1
      self.user.update_stats(true)
      self.status = true
    elsif self.wrong_guesses >= 6
      puts "Sorry. You died."
      puts "The correct word was: '#{@winning_word.upcase}'"
      puts nil
      puts "RIP, #{self.user.name}"
      puts nil
      self.user.update_stats(false)
      lost
      self.status = true
    end
  end

  def hangman
    case self.wrong_guesses
    when 0
      hangman0
    when 1
      hangman1
    when 2
      hangman2
    when 3
      hangman3
    when 4
      hangman4
    when 5
      hangman5
    when 6
  	  hangman6
    end
  end

  def runner
    until self.status == true
      self.guess
      self.hangman
      self.over?
    end
    self.high_scores
    puts nil
    puts "Would you like to play again? Y/N"
    response = self.get_user_input
    puts nil
    case response.upcase
    when "Y"
      new_game = Game.new
      new_game.runner
    when "N"
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
    puts "Your letter options are:"
    self.display_letters
    puts nil
    puts "Guess the word: '#{self.blank}'"
  end

  def find_and_set_user(name)
    users = User.all
    @user = users.find(lambda{User.new(name)}) do |user|
      user.name == name
    end
  end

  def high_scores
    User.display_stats
  end
end

