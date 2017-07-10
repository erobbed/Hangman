require "pry"

class User

  attr_reader :name, :wins, :losses, :games_played

  @@all = []

  def initialize(input)
  	@name = input.capitalize
  	@games_played = 0
  	@wins = 0
  	@losses = 0
    @@all << self
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
    
    self.order_users_by_scores.map do |user|
      puts nil
      puts "#{user.name}:"
      puts "Wins: #{user.wins}"
      puts "Losses: #{user.losses}"
      puts "Games Played: #{user.games_played}"
    end
  end

  def self.order_users_by_scores
    if self.all.length > 1
    #   binding.pry
      self.all.sort_by{|a| [(a.wins/a.games_played).to_f, a.wins]}.reverse
    else
      self.all
    end
  end

end
