class Board
  attr_accessor :cells
  
  def initialize
    self.reset!
  end
  
  def reset!
    self.cells = [" "," "," "," "," "," "," "," "," "]
  end
  
  def display
    puts " #{self.cells[0]} | #{self.cells[1]} | #{self.cells[2]} "
    puts "-----------"
    puts " #{self.cells[3]} | #{self.cells[4]} | #{self.cells[5]} "
    puts "-----------"
    puts " #{self.cells[6]} | #{self.cells[7]} | #{self.cells[8]} "
  end
  
  def index(cell)
    cell.to_i - 1
  end
  
  def position(cell)
    self.cells[index(cell)]
  end
  
  def full?
    self.cells.all? {|cell| cell == "X" || cell == "O"}
  end
  
  def turn_count
    self.cells.select {|cell| cell == "X" || cell == "O"}.length
  end
  
  def taken?(cell)
    self.cells[index(cell)] != " " && self.cells[index(cell)] != ""
  end
  
  def valid_move?(cell)
    index(cell).between?(0,8) && !taken?(cell)
  end
  
  def update(cell, player)
    self.cells[index(cell)] = player.token
  end
end