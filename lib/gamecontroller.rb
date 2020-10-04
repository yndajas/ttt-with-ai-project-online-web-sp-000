class GameController
  def players
    players = nil

    until players == "0" || players == "1" || players == "2"
      puts "\nHow many (human) players? (0-2)"
      players = gets.strip
    end

    players
  end

  def setup(players)
    if players == "2"
      game = Game.new
      puts "X plays first"
    elsif players == "1"
      human_turn = self.one_player_human_turn
      human_token = self.one_player_human_token
      game = self.one_player_config(human_turn, human_token)
    else players == "0"
      game = Game.new(player_1 = Players::Computer.new("X"), player_2 = Players::Computer.new("O"))
    end
    game
  end

  def one_player_human_turn
    human_turn = nil

    until human_turn == "1" || human_turn == "2"
      puts "\nDo you want to play first or second? (1/2)"
      human_turn = gets.strip
    end

    human_turn
  end

  def one_player_human_token
    human_token = nil

    until human_token == "X" || human_token == "O"
      puts "\nWhich token would you like to use? (X/O)"
      human_token = gets.strip.upcase
    end

    human_token
  end

  def one_player_config(human_turn, human_token)
    config = human_turn.concat(human_token)

    if config == "1X"
      game = Game.new(Players::Human.new("X"), Players::Computer.new("O"))
    elsif config == "1O"
      game = Game.new(Players::Human.new("O"), Players::Computer.new("X"))
    elsif config == "2X"
      game = Game.new(Players::Computer.new("O"), Players::Human.new("X"))
    else
      game = Game.new(Players::Computer.new("X"))
    end

    game
  end

  def start
    players = self.players

    game = self.setup(players)

    game.play

    self.start if self.replay?
  end

  def replay?
    replay = nil

    until replay == "n" || replay == "no" || replay == "y" || replay == "yes"
      puts "\nPlay again? (Y/N)"
      replay = gets.strip.downcase
    end

    if replay == "y" || replay == "yes"
      true
    else
      false
    end
  end
end
