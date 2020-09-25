require 'pry'

module Players
  class Computer < Player
    def move(board)
      binding.pry
      # cell = 1
      # until board.valid_move?(cell)
      #   cell += 1
      # end
      # cell.to_s
      
      self.win(board) || self.block(board) || self.ffork(board) || self.block_fork(board) || self.center(board) || self.opposite_corner(board) || self.corner(board) || self.side(board)
    end
    
    def win(board, token = self.token)
      move = false
      
      Game::WIN_COMBINATIONS.each do |combination|
        token_count = 0
        
        combination.each do |index|
          token_count += 1 if board.position(index + 1) == token
        end
        
        if token_count == 2
          combination.each do |index|
            move = (index + 1).to_s if board.valid_move?(index + 1)
          end
        end
      end
      
      move
    end
    
    def block(board)
      if self.token == "X"
        self.win(board, "O")
      else
        self.win(board, "X")
      end
    end

    def ffork(board, token = self.token)
      token == "X" ? opponent_token = "O" : opponent_token = "X"
      
      # get the combinations that don't contain the opponent's token
      
      winnable = []
      
      Game::WIN_COMBINATIONS.each do |combination|
        winnable << combination if !combination.collect {|index|board.position(index + 1)}.include?(opponent_token) # get the tokens in the combination (.collect + board.position) and check if they include opponent_token; if not, add combination to winnable
      end

      # filter those combinations by ones with one self.token already placed

      started = []
      
      winnable.each do |combination|
        combination.find do |index|
          started << combination if board.position(index + 1) == token
        end
      end
      
      # from those combinations, get all the valid moves (duplicating any that appear in multiple winnable combinations)
      
      valid_moves = []
      
      started.each do |combination|
        combination.each do |index|
          valid_moves << index if board.valid_move?(index + 1)
        end
      end
      
      # get a fork if one exists (valid moves that appear in more than one winnable and started combinations)
      
      index = valid_moves.find {|move| valid_moves.count(move) > 1}
      
      (index + 1).to_s if index != nil
      
    end

    def block_fork(board)
      # this is not quite right for blocking forks - it can't work out how to make a move that blocks two forks instead of one that blocks one (it just finds the first fork)
      # if multiple forks, create two in a row to force defence
      # shift code in #ffork to #forks and change so that is selects all fork moves with count > 1
      # change #ffork to take the [0] (or random) from #forks 
      # change #block_fork so that if #forks has more than one option, it looks for one in #winnable combinations that has an adjacent cell with the same token 
      if self.token == "X"
        self.ffork(board, "O")
      else
        self.ffork(board, "X")
      end
    end

    def center(board)
      if board.valid_move?(5)
        "5"
      end
    end

    def opposite_corner(board)
      opponent_token = "O"
      
      if self.token == "O"
        opponent_token = "X"
      end
      
      if board.position(1) == opponent_token
        "9"
      elsif board.position(3) == opponent_token
        "7"
      elsif board.position(7) == opponent_token
        "3"
      elsif board.position(9) == opponent_token
        "1"
      end
    end

    def corner(board)
      move = [1,3,7,9].find {|cell|board.valid_move?(cell)}
      move.to_s if move != nil
    end

    def side(board)
      move = [2,4,6,8].find {|cell|board.valid_move?(cell)}
      move.to_s if move != nil
    end
  end
end