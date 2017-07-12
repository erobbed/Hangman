class Runner
  include Categories
  include ASCII

  attr_reader :game

  def initialize
    self.welcome
    self.start_game
  end

  def create_game(name)
    @game = Game.new(self.find_and_set_user(name))
  end

  def start_game
    self.game.initial_round
  end

  def welcome #runner class
    logo
    puts "Please enter your name:"
    name = self.get_user_input
    puts nil
    self.find_and_set_user(name)
    self.create_game(name)
    puts "Hey, #{name.capitalize}!"
    puts nil
    self.options
    puts nil
    self.choose_difficulty
    puts nil
    print "Guess carefully, #{name.capitalize}. Your life is on the line"
    self.elipsis
    puts nil
    system "clear"
  end

  def elipsis
    array = [".", ".", ".", " "]
    array.each do |dot|
      sleep 0.5
      print dot
    end
  end

  def get_user_input #runner class
    gets.chomp
  end

  def choose_difficulty #runner class
    puts "Choose difficulty: EASY / HARD"
    difficulty = self.get_user_input.upcase
    until difficulty == "EASY" || difficulty == "HARD"
      self.invalid_input
      difficulty = self.get_user_input.upcase
    end
    self.game.difficulty = difficulty
    self.choose_category
  end

  def options
    puts "Please guess a letter or guess the word."
    puts "To exit, please type 'QUIT'."
    puts "To see your options at any time, please type 'HELP'."
  end

  def choose_category #runner class
    if self.game.difficulty == "HARD"
      puts nil
      puts "Categories:"
      @@hard_categories.each {|category| puts category}
      puts nil
    elsif self.game.difficulty == "EASY"
      puts nil
      puts "Categories:"
      @@easy_categories.each {|category| puts category}
      puts nil
    end
    puts "Choose a category:"
    self.game.winning_word = self.send(self.get_user_input.downcase).sample
  end

  def invalid_input
    puts nil
    puts "Invalid input. Please select a valid option:"
  end

  def guess #runner class
    letter = self.get_user_input.downcase
    system "clear"
  	if letter == self.game.winning_word
      self.game.blank = letter.split("")
      self.game.hangman
  	elsif self.game.winning_word.include?(letter)
      self.game.right_answer(letter)
    elsif letter.upcase == "QUIT"
      puts nil
      puts "Okay! Goodbye!"
      self.game.user.games_played += 1
      self.game.status = true
  	elsif letter.upcase == "HELP"
      self.game.options
    else
      self.game.wrong_answer(letter)
    end
  end

  def run #runner class
    until self.game.status == true
      self.guess
      self.game.over?
    end
    self.game.save
    self.game.high_scores
    puts nil
    puts "Would you like to play again? Y/N"
    response = self.get_user_input
    puts nil
    case response.upcase
    when "Y"
      runner = Runner.new
      runner.run
    when "N"
      puts "Goodbye!"
    end
  end

  def find_and_set_user(name)
    users = User.all
    @user = users.find(lambda{User.new(name)}) do |user|
      user.name == name
    end
  end
end
