class Piece
  attr_accessor :color, :name

  def initialize(name='none', color='none')
    @name = name
    @color = color
  end
end
