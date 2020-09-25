require 'pry'

module Players
  class Computer < Player
    def move(board)
      binding.pry
      cell = 1
      until board.valid_move?(cell)
        cell += 1
      end
      cell.to_s
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
        winnable << combination if !combination.include?(opponent_token)
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
      
      # get the mode/most frequent valid_move (i.e. one that will )
      
      valid_moves.max_by{|move|valid_moves.count(move)}
    end

    def block_fork(board)
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
      [1,3,7,9].find {|cell|cell.to_s if board.valid_move?(cell)}
    end

    def side(board)
      [2,4,6,8].find {|cell|cell.to_s if board.valid_move?(cell)}
    end
  end
end