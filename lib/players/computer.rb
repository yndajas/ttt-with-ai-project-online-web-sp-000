require 'pry'

module Players
  class Computer < Player
    def move(board)
      cell = 1
      9.times do
        binding.pry
        return cell.to_s if board.valid_move?(cell)
      end
    end
  end
end