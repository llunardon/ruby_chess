# lib/cell.rb

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
