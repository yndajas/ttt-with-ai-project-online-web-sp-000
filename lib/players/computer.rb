require 'pry'

module Players
  class Computer < Player
    def move(board)
      cell = 1
      until board.valid_move?(cell)
        cell += 1
      end
      cell.to_s
    end
  end
end