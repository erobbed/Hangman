class User

# user is instance of the class, initializes with a name and inserts self into @@all
  attr_reader :name, :wins, :losses, :games_played

  @@all = []

  def initialize(input)
  	@name = input
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
end
