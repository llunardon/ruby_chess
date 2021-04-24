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
end
