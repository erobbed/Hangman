class Game
  include ASCII

  attr_accessor :user, :wrong_guesses, :status, :alpha, :blank,
  :winning_word, :category, :difficulty

  @@all = []
  def initialize(user)
    self.user = user
    self.wrong_guesses = 0
    self.alpha = ("A".."Z").to_a
    self.status = false
  end

  # def blank
  #   @blank.join(" ").upcase
  # end

  def display_letters
    puts "#{self.alpha.join(" ")}"
  end

  def right_answer(letter)
    self.hangman
    puts nil
    puts "Nice! Keep going!"
    self.fill_in(letter)
    self.alpha.delete(letter.upcase)
    puts nil
    puts "Your remaining letter options are:"
    self.display_letters
  end

  def wrong_answer(letter)
    self.wrong_guesses +=1
    self.hangman
    puts nil
    puts "Uh-oh! Try again:"
    puts "#{@blank.join(" ").upcase}"
    self.alpha.delete(letter.upcase)
    puts nil
    puts "Your remaining letter options are:"
    self.display_letters
  end

  def fill_in(letter)
    self.winning_word.split("").each_with_index do |l, ind|
      if l == letter
        # binding.pry
        self.blank[ind] = letter
      end
    end
    puts "#{@blank.join(" ").upcase}"
  end

  def over?
    if (self.blank.join == self.winning_word) && (self.winning_word == "hydra")
      puts "YOU GOT IT! HAIL #{self.winning_word.upcase}!"
      # user.wins += 1
      self.user.update_stats(true)
      self.status = true
    elsif self.blank.join == self.winning_word
      puts "You got it! The word was '#{self.winning_word.upcase}'!"
      # user.wins += 1
      self.user.update_stats(true)
      self.status = true
    elsif self.wrong_guesses >= 6
      puts "Sorry. You died."
      puts "The correct word was: '#{self.winning_word.upcase}'"
      puts nil
      puts "RIP, #{self.user.name}"
      puts nil
      self.user.update_stats(false)
      lost
      self.status = true
    end
  end

  def save
    @@all << self
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

  def initial_round
  	self.hangman
    puts nil
    self.blank = self.winning_word.split("").map {|letter| "_" }
    puts "Guess the word:"
    puts "#{@blank.join(" ").upcase}"
    puts nil
    puts "Your letter options are:"
    self.display_letters
  end

  def high_scores
    User.display_stats
  end
end
