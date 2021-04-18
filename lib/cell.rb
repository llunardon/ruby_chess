require_relative 'pieces.rb'

class Cell
  attr_accessor :piece

  def initialize()
    @piece = Piece.new()
  end

  def is_empty?()
    @piece.name == 'none' ? true : false 
  end
end

#test_cell = Cell.new
#p test_cell.piece
#p test_cell.is_empty?
#
#test_cell.piece.name = 'pawn'
#test_cell.piece.color = 'white'
#p test_cell.piece
#p test_cell.is_empty?
