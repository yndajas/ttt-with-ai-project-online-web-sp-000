require 'pry'

module Players
  class Computer < Player
    def move(board)
      move = nil
      board.cells.each_with_index do |cell, index|
        move = index if board.valid_move?(index)
      end
      move
      
    end
  end
end