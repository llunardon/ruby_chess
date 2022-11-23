# lib/pieces.rb

class Piece
  attr_accessor :color, :name, :possible_moves

  def initialize(name='none', color='none')
    @name = name
    @color = color
    @possible_moves = []
  end

  def set(name, color)
    @name = name
    @color = color
  end

  def is_white?()
    return @color == 'white'
  end

  def is_black?()
    return @color == 'black'
  end

  def is_none?()
    return @color == 'none'
  end
end
