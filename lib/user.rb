require "pry"

class User

# user is instance of the class, initializes with a name and inserts self into @@all
  attr_reader :name, :wins, :losses, :games_played

  @@all = []

  def initialize(input)
  	@name = input.capitalize
  	@games_played = 0
  	@wins = 0
  	@losses = 0
    @@all << self #names repeat in @@all. need to check for repeats
  end

  def self.all
    @@all
  end

  def update_stats(win)
    if win
      @wins += 1
      @games_played += 1
    else
      @losses += 1
      @games_played += 1
    end
  end

  def self.display_stats
    puts nil
    puts "HIGH SCORES:"
    self.all.map do |user|
      puts nil
      puts "#{user.name}:"
      puts "Wins: #{user.wins}"
      puts "Losses: #{user.losses}"
      puts "Games Played: #{user.games_played}"
    end
  end
end
